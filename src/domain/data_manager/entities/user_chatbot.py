from datetime import datetime

from pydantic import BaseModel


class UserChatbot(BaseModel):
    creation_date: datetime
    chatbot_id: str
    user_id: str
    name: str
    description: str = ''
    index_name: str
    total_questions: int = 0
    open_ai_api_key: str
    pinecone_api_key: str
    pinecone_environment: str
    is_live: bool = False
    is_active: bool = False
