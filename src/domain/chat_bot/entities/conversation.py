from datetime import datetime

from pydantic import BaseModel

from src.domain.chat_bot.entities.chat_message import ChatMessage


class Conversation(BaseModel):
    creation_date: datetime
    conversation_id: str
    chatbot_id: str
    messages: list[ChatMessage] = []
