from operator import itemgetter

from fastapi import APIRouter, WebSocket, WebSocketDisconnect
from icecream import ic
from langchain_core.messages import get_buffer_string, HumanMessage
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate, PromptTemplate, format_document
from langchain_core.runnables import RunnableParallel, RunnablePassthrough
from langchain_core.tracers import ConsoleCallbackHandler
from langchain_openai import OpenAIEmbeddings, ChatOpenAI

from src.domain.chat_bot.entities.answer import Answer
from src.domain.chat_bot.entities.question import Question
from src.domain.chat_bot.errors.errors import ExistingConnectionError
from src.infrastructure.chat_bot.chat_connections_manager import chat_connection_manager
from src.infrastructure.chat_bot.chatbot_x import ChatBotX
from src.infrastructure.chat_bot.pinecone_repository import PineconeRepository

route = APIRouter(prefix='/chatbot',
                  tags=['chatbot'], )


@route.post('/v1/qa-chatbot')
def qa_chatbot(question: Question) -> Answer:
    chatbot = ChatBotX(index_name='tobecv', repo=PineconeRepository(),
                       embeddings_model=OpenAIEmbeddings())
    answer = chatbot.query_question(question)
    return answer


@route.websocket('/v1/ws/chat-bot')
async def agent_chatbot(websocket: WebSocket, chat_id: str):
    await chat_connection_manager.connect(websocket, chat_id)
    try:
        repo = PineconeRepository()
        embeddings = OpenAIEmbeddings()
        llm = ChatOpenAI(model_name="gpt-3.5-turbo", temperature=0)
        repo.init()
        vectorstore = repo.get_vectorstore('tobecv', embeddings, "text")
        retriever = vectorstore.as_retriever(search_type="similarity", search_kwargs={"k": 4})
        # template: str = """You are an assistant for question-answering tasks. Use the following pieces of retrieved context to answer the question.
        #      If you don't know the answer, just say that you don't know. Use three sentences maximum and keep the answer concise.
        #      Only respond in the language in which the question was asked.
        #      Question: {question}
        #      <context>
        #      Context: {context}
        #      </context>
        #      Answer:"""
        # custom_prompt = ChatPromptTemplate.from_messages([("system", template)])
        # chain = (
        #         RunnableParallel(context=retriever, question=RunnablePassthrough())
        #         | custom_prompt
        #         | llm
        #         | StrOutputParser()
        # )
        t1 = """Given the following conversation and a follow up question, rephrase the follow up question to be a standalone question, in its original language.

        Chat History:
        {chat_history}
        Follow Up Input: {question}
        Standalone question:"""
        CONDENSE_QUESTION_PROMPT = PromptTemplate.from_template(t1)
        t2 = """Answer the question based only on the following context:
        {context}

        Question: {question}
        """
        ANSWER_PROMPT = ChatPromptTemplate.from_template(t2)
        DEFAULT_DOCUMENT_PROMPT = PromptTemplate.from_template(template="{page_content}")

        def _combine_documents(
                docs, document_prompt=DEFAULT_DOCUMENT_PROMPT, document_separator="\n\n"
        ):
            doc_strings = [format_document(doc, document_prompt) for doc in docs]
            return document_separator.join(doc_strings)

        _inputs = RunnableParallel(
            standalone_question=RunnablePassthrough.assign(
                chat_history=lambda x: get_buffer_string(x["chat_history"])
            ) | CONDENSE_QUESTION_PROMPT
                                | ChatOpenAI(temperature=0)
                                | StrOutputParser(),
        )

        _context = {
            "context": itemgetter("standalone_question") | retriever | _combine_documents,
            "question": lambda x: x["standalone_question"],
        }

        chain = _inputs | _context | ANSWER_PROMPT | ChatOpenAI()
        chat_history = []
        while True:
            ic(chat_history)
            data = await websocket.receive_json()
            query = Question(**data)
            response = chain.invoke({
                "question": query.text,
                "chat_history": chat_history,
            },
                config={'callbacks': [ConsoleCallbackHandler()]})
            chat_history.extend([HumanMessage(content=query.text), response])

            answer = Answer(text=response.content, )
            await chat_connection_manager.brod_cast_user(answer.model_dump(), chat_id)
    except WebSocketDisconnect:
        ic(f"Close connection with chat_id: {websocket.chat_id}")
        await chat_connection_manager.disconnect(websocket)
    except ExistingConnectionError:
        ic("Existing connection detected, rejecting the new connection")
