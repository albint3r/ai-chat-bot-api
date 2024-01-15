from fastapi import APIRouter, WebSocket, WebSocketDisconnect
from icecream import ic
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import RunnableParallel, RunnablePassthrough
from langchain_core.tracers import ConsoleCallbackHandler
from langchain_openai import OpenAIEmbeddings, ChatOpenAI

from src.domain.chat_bot.entities.answer import Answer
from src.domain.chat_bot.entities.question import Question
from src.domain.chat_bot.errors.errors import ExistingConnectionError, ConnectionNotExist
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
        template: str = """You are an assistant for question-answering tasks. Use the following pieces of retrieved context to answer the question.
             If you don't know the answer, just say that you don't know. Use three sentences maximum and keep the answer concise.
             Only respond in the language in which the question was asked.
             Question: {question}
             <context>
             Context: {context}
             </context>
             Answer:"""
        custom_prompt = ChatPromptTemplate.from_messages([("system", template)])
        chain = (
                RunnableParallel(context=retriever, question=RunnablePassthrough())
                | custom_prompt
                | llm
                | StrOutputParser()
        )
        while True:
            data = await websocket.receive_json()
            query = Question(**data)
            response = chain.invoke(query.text,
                                    config={'callbacks': [ConsoleCallbackHandler()]})
            answer = Answer(text=response)
            await chat_connection_manager.brod_cast_user(answer.model_dump(), chat_id)
    except WebSocketDisconnect:
        ic(f"Close connection with chat_id: {websocket.chat_id}")
        await chat_connection_manager.disconnect(websocket)
    except ExistingConnectionError:
        ic("Existing connection detected, rejecting the new connection")
