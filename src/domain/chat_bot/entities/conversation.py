from datetime import datetime

from pydantic import BaseModel, Field

from src.domain.chat_bot.entities.chat_message import ChatMessage

import uuid


class Conversation(BaseModel):
    creation_date: datetime = Field(default=datetime.now())
    conversation_id: str = Field(default=uuid.uuid4())
    chatbot_id: str
    messages: list[ChatMessage] = []
