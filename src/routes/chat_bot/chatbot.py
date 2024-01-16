from fastapi import APIRouter, WebSocket, WebSocketDisconnect
from icecream import ic
from langchain.memory import ConversationBufferMemory
from langchain_openai import OpenAIEmbeddings

from src.domain.chat_bot.entities.answer import Answer
from src.domain.chat_bot.entities.question import Question
from src.domain.chat_bot.errors.errors import ExistingConnectionError
from src.infrastructure.chat_bot.chat_connections_manager import chat_connection_manager
from src.infrastructure.chat_bot.chatbot_qa_with_memory import ChatBotQAWithMemory
from src.infrastructure.chat_bot.chatbot_x import ChatBotX
from src.infrastructure.chat_bot.pinecone_repository import PineconeRepository

route = APIRouter(prefix='/chatbot',
                  tags=['Chat Bot'], )


@route.post('/v1/qa-chatbot')
def qa_chatbot(question: Question) -> Answer:
    chatbot = ChatBotX(index_name='tobecv', repo=PineconeRepository(),
                       embeddings_model=OpenAIEmbeddings())
    answer = chatbot.query_question(question)
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
