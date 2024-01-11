from pydantic import BaseModel


class IMessage(BaseModel):
    text: str
