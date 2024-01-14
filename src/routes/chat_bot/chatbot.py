from fastapi import APIRouter, WebSocket, WebSocketDisconnect, WebSocketException, status
from icecream import ic
from langchain_openai import OpenAIEmbeddings

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
async def agent_chatbot(websocket: WebSocket, user_id: str):
    await chat_connection_manager.connect(websocket, user_id)
    try:
        while True:
            data = await websocket.receive_json()
    except WebSocketDisconnect:
        await chat_connection_manager.disconnect(websocket)
        raise WebSocketException(code=status.WS_1008_POLICY_VIOLATION,
                                 reason=f'Error: User: {user_id} disconnect from session')
    except ExistingConnectionError:
        ic("Existing connection detected, rejecting the new connection")
