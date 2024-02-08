from fastapi import APIRouter, WebSocket, WebSocketDisconnect, HTTPException, status
from icecream import ic
from langchain.memory import ConversationBufferMemory
from langchain_openai import OpenAIEmbeddings, ChatOpenAI

from src.db.db import db
from src.domain.chat_bot.entities.answer import Answer
from src.domain.chat_bot.entities.chat_message import ChatMessage
from src.domain.chat_bot.entities.conversation import Conversation
from src.domain.chat_bot.entities.question import Question
from src.domain.chat_bot.errors.errors import ExistingConnectionError
from src.domain.data_manager.entities.user_chatbot import UserChatbot
from src.infrastructure.auth.auth_repository import AuthRepository
from src.infrastructure.chat_bot.chat_connections_manager import chat_connection_manager
from src.infrastructure.chat_bot.chatbot_qa_with_memory import ChatBotQAWithMemory
from src.infrastructure.chat_bot.chatbot_repository import ChatBotRepository
from src.infrastructure.chat_bot.chatbot_x import ChatBotX
from src.infrastructure.chat_bot.pinecone_repository import PineconeRepository

route = APIRouter(prefix='/chatbot',
                  tags=['Chat Bot'], )


@route.post('/v1/chatbots/{chat_id}')
def get_chatbot_info(chat_id: str) -> UserChatbot:
    try:
        auth_repo = AuthRepository(db=db)
        chatbot_info = auth_repo.get_user_chatbot(chat_id)
        # Check if the chatbot is live
        if chatbot_info.is_active:
            return chatbot_info
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f'The chat Id: {chat_id} dont exist')
    except Exception:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f'The chat Id: {chat_id} dont exist')


@route.post('/v1/qa-chatbot/{chat_id}')
def qa_chatbot(question: Question, chat_id: str) -> Answer:
    # These are the default Values of the Chat.
    auth_repo = AuthRepository(db=db)
    chatbot_info = auth_repo.get_user_chatbot(chat_id)
    if chatbot_info.is_active:
        chatbot = ChatBotX(index_name=chatbot_info.index_name,
                           repo=PineconeRepository(api_key=chatbot_info.pinecone_api_key,
                                                   environment=chatbot_info.pinecone_environment),
                           embeddings_model=OpenAIEmbeddings(openai_api_key=chatbot_info.open_ai_api_key))
        answer = chatbot.query_question(question,
                                        llm=ChatOpenAI(model_name="gpt-3.5-turbo",
                                                       temperature=0,
                                                       api_key=chatbot_info.open_ai_api_key))
        return answer
    raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f'The chat Id: {chat_id} dont exist')


@route.websocket('/v1/ws/qa-chatbot')
async def qa_with_memory_chatbot(websocket: WebSocket, chat_id: str):
    await chat_connection_manager.connect(websocket, chat_id)
    auth_repo = AuthRepository(db=db)
    chatbot_repo = ChatBotRepository(db=db)
    chatbot_info = auth_repo.get_user_chatbot(chat_id)
    # We need to save the conversation messages:
    # 1) We need to create a conversation id
    conversation = Conversation(chatbot_id=chatbot_info.chatbot_id)
    chatbot_repo.create_conversation(conversation.chatbot_id, conversation.conversation_id)
    if chatbot_info.is_active:
        try:
            chatbot = ChatBotQAWithMemory(index_name=chatbot_info.index_name,
                                          repo=PineconeRepository(api_key=chatbot_info.pinecone_api_key,
                                                                  environment=chatbot_info.pinecone_environment),
                                          embeddings_model=OpenAIEmbeddings(
                                              openai_api_key=chatbot_info.open_ai_api_key))
            chatbot.memory = ConversationBufferMemory(return_messages=True, output_key="answer", input_key="question")
            while True:
                data = await websocket.receive_json()
                query = Question(**data)
                # Here We save the question made by the user in the Conversation and message table
                chat_msg = ChatMessage.from_message(str(conversation.conversation_id), query)
                conversation.messages.append(chat_msg)
                chatbot_repo.create_message(conversation_id=str(conversation.conversation_id), content=chat_msg.content)
                inputs = {"question": query.text}
                answer = chatbot.query_question(query, inputs, llm=ChatOpenAI(model_name="gpt-3.5-turbo",
                                                                              temperature=0,
                                                                              api_key=chatbot_info.open_ai_api_key))
                # Here We save the Answer of the AI assistant in the Conversation and message table.
                chat_msg = ChatMessage.from_message(str(conversation.conversation_id), answer)
                conversation.messages.append(chat_msg)
                chatbot_repo.create_message(conversation_id=str(conversation.conversation_id), content=chat_msg.content)
                print('*-' * 100)
                print(conversation)
                print('*-' * 100)
                await chat_connection_manager.brod_cast_user(answer.model_dump(), chat_id)

        except WebSocketDisconnect:
            ic(f"Close connection with chat_id: {chat_id}")
            await chat_connection_manager.disconnect(websocket)
        except ExistingConnectionError:
            ic("Existing connection detected, rejecting the new connection")
    raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f'The chat Id: {chat_id} dont exist')
