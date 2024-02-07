from pydantic import BaseModel

from src.db.db import AbstractDB
from src.domain.chat_bot.entities.chat_message import ChatMessage
from src.domain.chat_bot.entities.conversation import Conversation
from src.domain.chat_bot.errors.errors import ExistingConversationError, CreateConversationError


class ChatBotRepository(BaseModel):
    db: AbstractDB

    def get_conversation(self, conversation_id: str) -> Conversation:
        query = f"SELECT * FROM conversations WHERE conversation_id='{conversation_id}';"
        response = self.db.query(query)
        if response:
            return Conversation(**response)
        raise ExistingConversationError(f'The conversation id: {conversation_id} not exist.')

    def create_conversation(self, chatbot_id: str, conversation_id: str) -> None:
        try:
            query = f"INSERT INTO conversation (chatbot_id, conversation_id) VALUES ('{chatbot_id}', '{conversation_id}');"
            self.db.execute(query)
        except Exception as _:
            raise CreateConversationError(f'It was a problem creating the conversation id: {conversation_id}')

    def get_messages(self, conversation_id: str) -> list[ChatMessage]:
        query = f"SELECT * FROM messages WHERE conversation_id= '{conversation_id}';"
        responses = self.db.query(query, fetch_all=True)
        if responses:
            return [ChatMessage(**response) for response in responses]
        raise ExistingConversationError(f'The conversation id: {conversation_id} not exist.')

    def create_message(self, conversation_id: str) -> None:
        query = f"INSERT INTO messages WHERE conversation_id={conversation_id}"
