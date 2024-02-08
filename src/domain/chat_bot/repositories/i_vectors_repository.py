from langchain_core.embeddings import Embeddings
from pydantic import BaseModel
from abc import ABC, abstractmethod


class IVectorRepository(BaseModel, ABC):
    embeddings_model: Embeddings | None = None

    class Config:
        arbitrary_types_allowed = True

    @abstractmethod
    def init(self, **kwargs):
        """Initialize instance from Vector Db"""

    @abstractmethod
    def get(self, index_name: str):
        """Retrival the index db"""

    @abstractmethod
    def get_vectorstore(self, index_name: str, embeddings: Embeddings, text_key='text'):
        """Create vectorstore connection"""

    @abstractmethod
    def create(self, index_name: str, dimension=1536, metric='cosine'):
        """Create a new index db"""

    @abstractmethod
    def delete(self, index_name: str, pinecone_api_key: str):
        """Delete the user index in Pinecone"""
