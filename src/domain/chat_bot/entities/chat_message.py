from datetime import datetime

from pydantic import BaseModel


class ChatMessage(BaseModel):
    creation_date: datetime
    conversation_id: str
    chatbot_id: str
    content: str
