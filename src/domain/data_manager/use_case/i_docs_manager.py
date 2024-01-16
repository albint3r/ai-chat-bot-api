import shutil
from pathlib import Path

from fastapi import UploadFile
from langchain_core.documents import Document
from langchain_core.embeddings import Embeddings
from pydantic import BaseModel, validate_call
from abc import ABC, abstractmethod

from starlette.responses import JSONResponse

from src.domain.chat_bot.repositories.i_vectors_repository import IVectorRepository


class IDocsManager(BaseModel, ABC):
    files_path: list[str]
    repo: IVectorRepository
    embeddings_model: Embeddings | None = None

    class Config:
        arbitrary_types_allowed = True

    @validate_call()
    @abstractmethod
    def load_files(self, files_path: list[str] | None = None, encoding='utf-8') -> list[Document]:
        """Load all the files types and return a list of documents"""

    @validate_call()
    @abstractmethod
    def add_new_data(self, index_name: str, new_documents: list[Document]):
        """Add new questions to index vector db."""

    @validate_call()
    @abstractmethod
    def create_index(self, index_name: str, files_path: list[str] | None = None, encoding='utf-8'):
        """Create a new Index in the vector db"""

    @validate_call()
    @abstractmethod
    def get_index(self, index_name: str):
        """Create a new Index in the vector db"""

    @validate_call()
    @abstractmethod
    def search_similarity(self, index_name: str, query: str):
        """Search for semantic similarities in the db from a user query."""

    @staticmethod
    @abstractmethod
    def save_uploaded_file(file: UploadFile):
        """Save Uploaded CSV Files"""
