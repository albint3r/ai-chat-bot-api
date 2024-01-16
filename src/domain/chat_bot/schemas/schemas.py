from langchain_core.documents import Document
from pydantic import Field, BaseModel


class RequestDocument(BaseModel):
    page_content: str
    metadata: dict = {}
