from langchain_core.embeddings import Embeddings
from pydantic import BaseModel, validate_call
from abc import ABC, abstractmethod


class IVectorRepository(BaseModel, ABC):
    embeddings_model: Embeddings | None = None

    class Config:
        arbitrary_types_allowed = True

    @validate_call()
    @abstractmethod
    def init(self):
        """Initialize instance from Vector Db"""

    @validate_call()
    @abstractmethod
    def get(self, index_name: str):
        """Retrival the index db"""


    @abstractmethod
    def get_vectorstore(self, index_name: str, embeddings: Embeddings, text_key='text'):
        """Create vectorstore connection"""

    @validate_call()
    @abstractmethod
    def create(self, index_name: str, dimension=1536, metric='cosine'):
        """Create a new index db"""
