import uuid
from datetime import datetime

from icecream import ic
from pydantic import BaseModel, Field

from src.domain.chat_bot.entities.i_message import IMessage


class ChatMessage(BaseModel):
    creation_date: datetime = Field(default=datetime.now())
    message_id: str = Field(default=uuid.uuid4())
    conversation_id: str
    content: str

    @classmethod
    def from_message(cls, conversation_id: str, msg: IMessage) -> "ChatMessage":
        """Create an instance of the class ChatMessage from a Question Object."""
        return cls(conversation_id=conversation_id, content=msg.text)
