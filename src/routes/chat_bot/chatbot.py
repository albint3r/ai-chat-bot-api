from fastapi import APIRouter, WebSocket, WebSocketDisconnect, HTTPException, status
from icecream import ic
from langchain.memory import ConversationBufferMemory
from langchain_openai import OpenAIEmbeddings, ChatOpenAI

from src.db.db import db
from src.domain.chat_bot.entities.answer import Answer
from src.domain.chat_bot.entities.question import Question
from src.domain.chat_bot.errors.errors import ExistingConnectionError
from src.domain.data_manager.entities.user_chatbot import UserChatbot
from src.infrastructure.auth.auth_repository import AuthRepository
from src.infrastructure.chat_bot.chat_connections_manager import chat_connection_manager
from src.infrastructure.chat_bot.chatbot_qa_with_memory import ChatBotQAWithMemory
from src.infrastructure.chat_bot.chatbot_x import ChatBotX
from src.infrastructure.chat_bot.pinecone_repository import PineconeRepository

route = APIRouter(prefix='/chatbot',
                  tags=['Chat Bot'], )


@route.post('/v1/chatbots/{chat_id}')
def get_chatbot_info(chat_id: str) -> UserChatbot:
    try:
        auth_repo = AuthRepository(db=db)
        return auth_repo.get_user_chatbot(chat_id)
    except Exception:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f'The chat Id: {chat_id} dont exist')


@route.post('/v1/qa-chatbot/{chat_id}')
def qa_chatbot(question: Question, chat_id: str) -> Answer:
    # These are the default Values of the Chat.
    auth_repo = AuthRepository(db=db)
    chabot_info = auth_repo.get_user_chatbot(chat_id)
    chatbot = ChatBotX(index_name=chabot_info.index_name,
                       repo=PineconeRepository(api_key=chabot_info.pinecone_api_key,
                                               environment=chabot_info.pinecone_environment),
                       embeddings_model=OpenAIEmbeddings(openai_api_key=chabot_info.open_ai_api_key))
    answer = chatbot.query_question(question, llm=ChatOpenAI(model_name="gpt-3.5-turbo",
                                                             temperature=0,
                                                             api_key=chabot_info.open_ai_api_key))
    return answer


@route.websocket('/v1/ws/qa-chatbot')
async def qa_with_memory_chatbot(websocket: WebSocket, chat_id: str):
    await chat_connection_manager.connect(websocket, chat_id)
    try:
        chatbot = ChatBotQAWithMemory(index_name='tobecv', repo=PineconeRepository(),
                                      embeddings_model=OpenAIEmbeddings())
        chatbot.memory = ConversationBufferMemory(return_messages=True, output_key="answer", input_key="question")
        while True:
            data = await websocket.receive_json()
            query = Question(**data)
            inputs = {"question": query.text}
            answer = chatbot.query_question(query, inputs)
            await chat_connection_manager.brod_cast_user(answer.model_dump(), chat_id)

    except WebSocketDisconnect:
        ic(f"Close connection with chat_id: {chat_id}")
        await chat_connection_manager.disconnect(websocket)
    except ExistingConnectionError:
        ic("Existing connection detected, rejecting the new connection")
