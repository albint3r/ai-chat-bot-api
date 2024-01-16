from operator import itemgetter

from fastapi import APIRouter, WebSocket, WebSocketDisconnect
from icecream import ic
from langchain.memory import ConversationBufferMemory
from langchain_core.documents import Document
from langchain_core.messages import get_buffer_string, HumanMessage
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate, PromptTemplate, format_document
from langchain_core.runnables import RunnableParallel, RunnablePassthrough, RunnableLambda
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
        retriever = vectorstore.as_retriever()
        memory = ConversationBufferMemory(
            return_messages=True, output_key="answer", input_key="question"
        )
        t1 = """Given the following conversation and a follow up question, rephrase the follow up question to be a standalone question, in its original language.

        Chat History:
        {chat_history}
        Follow Up Input: {question}
        Standalone question:"""
        CONDENSE_QUESTION_PROMPT = PromptTemplate.from_template(t1)

        t2 = """Use the following pieces of context to answer the question at the end.
        If you don't know the answer, just say that you don't know, don't try to make up an answer.
        Use three sentences maximum and keep the answer as concise as possible.
        Always say "thanks for asking!" at the end of the answer.
    
        {context}
    
        Question: {question}
    
        Helpful Answer:"""
        ANSWER_PROMPT = ChatPromptTemplate.from_template(t2)
        DEFAULT_DOCUMENT_PROMPT = PromptTemplate.from_template(template="{page_content}")

        def _combine_documents(
                docs: list[Document], document_prompt=DEFAULT_DOCUMENT_PROMPT, document_separator="\n\n"
        ):
            doc_strings = [format_document(doc, document_prompt) for doc in docs]
            return document_separator.join(doc_strings)

        loaded_memory = RunnablePassthrough.assign(
            chat_history=RunnableLambda(memory.load_memory_variables) | itemgetter("history"),
        )

        standalone_question = RunnableParallel(
            standalone_question={
                # create their own string in the value [standalone_question] this value would be inserted later.
                "standalone_question": {
                                           "question": lambda x: x["question"],
                                           "chat_history": lambda x: get_buffer_string(x["chat_history"]),
                                       }
                                       | CONDENSE_QUESTION_PROMPT
                                       | llm
                                       | StrOutputParser(),
            }
        )
        # Now we retrieve the documents
        retrieved_documents = {
            "docs": itemgetter("standalone_question") | RunnableLambda(lambda x: x['standalone_question']) | retriever,
            "question": lambda x: x["standalone_question"],
        }
        # Now we construct the inputs for the final prompt
        final_inputs = {
            "context": lambda x: _combine_documents(x["docs"]),
            "question": itemgetter("question"),
        }
        # And finally, we do the part that returns the answers
        answer = {
            "answer": final_inputs | ANSWER_PROMPT | llm | StrOutputParser(),
            "docs": itemgetter("docs"),
        }
        # And now we put it all together!
        chain = loaded_memory | standalone_question | retrieved_documents | answer

        while True:
            data = await websocket.receive_json()
            query = Question(**data)
            inputs = {"question": query.text}
            response = chain.invoke(inputs, config={'callbacks': [ConsoleCallbackHandler()]})

            ic(response)
            answer = Answer(text=response['answer'], )
            await chat_connection_manager.brod_cast_user(answer.model_dump(), chat_id)
            # Note that the memory does not save automatically
            # This will be improved in the future
            # For now you need to save it yourself
            memory.save_context(inputs, {"answer": response["answer"]})
            ic(memory.load_memory_variables({}))

    except WebSocketDisconnect:
        ic(f"Close connection with chat_id: {websocket.chat_id}")
        await chat_connection_manager.disconnect(websocket)
    except ExistingConnectionError:
        ic("Existing connection detected, rejecting the new connection")
