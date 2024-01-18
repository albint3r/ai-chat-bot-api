from pydantic import BaseModel


class RequestDocument(BaseModel):
    page_content: str
    metadata: dict = {}


class RequestUserChatbotInfo(BaseModel):
    """Request Schema to obtain the information to create the Chatbot User"""
    name: str
    description: str = ""
    index_name: str
    open_ai_api_key: str
    pinecone_api_key: str
    pinecone_environment: str
