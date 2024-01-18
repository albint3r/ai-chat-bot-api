from langchain_core.documents import Document
from pydantic import Field, BaseModel, UUID4


class RequestDocument(BaseModel):
    page_content: str
    metadata: dict = {}


class RequestUserChatbotInfo(BaseModel):
    """Request Schema to obtain the information to create the Chatbot User"""
    name: str
    description: str = ""
    open_ai_api_key: str
    pinecone_api_key: str
    pinecone_environment: str

