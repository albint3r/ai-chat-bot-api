import re

import pinecone
from icecream import ic
from langchain_community.document_loaders import CSVLoader
from langchain_community.vectorstores.pinecone import Pinecone
from langchain_core.documents import Document

from src.domain.chat_bot.errors.errors import ErrorFormatIndexName
from src.domain.chat_bot.use_case.i_docs_manager import IDocsManager


class CVSDocsManager(IDocsManager):

    def _get_documents_text(self, documents: list[Document], size: int = 2) -> list[str]:
        return [documents[i].page_content for i in range(size)]

    def load_files(self, files_path: list[str] | None = None, encoding='utf-8') -> list[Document]:
        # Update the files property
        self.files_path = files_path if files_path else self.files_path
        documents = []
        for file_path in self.files_path:
            loader = CSVLoader(file_path=file_path, encoding=encoding)
            if not documents:
                documents = loader.load()
                continue
            documents.extend(loader.load())
        return documents

    def add_new_data(self, index_name: str, new_documents: list[Document]) -> None:
        self.repo.init()
        index = self.repo.get(index_name)
        vectorstore = Pinecone(index, self.embeddings_model.embed_query, "text")
        documents = self._get_documents_text(new_documents, size=len(new_documents))
        ic(f'Adding new documents question to index: {index}')
        vectorstore.add_texts(documents)

    def _validate_index_name(self, index_name: str) -> bool:
        """Validate the index name have the Pinecone Format"""
        pattern = r'^[a-z0-9-]+$'
        return bool(re.match(pattern, index_name))

    def create_index(self, index_name: str, files_path: list[str] | None = None, encoding='utf-8') -> Pinecone:
        # Create OpenAI Model and Init Pinecone
        if not self._validate_index_name(index_name):
            raise ErrorFormatIndexName('Can only contain lowercase letters, numbers, and hyphens.')
        self.repo.init()
        # Create index if not exist
        if index_name not in pinecone.list_indexes():
            # Retrival all the documents from CSV
            documents = self.load_files(files_path, encoding)
            self.repo.create(index_name=index_name)
            ic(f'Create for the first time index: {index_name}')
            return Pinecone.from_documents(documents, self.embeddings_model, index_name=index_name)
        ic(f'Index {index_name} already exist')
        return Pinecone.from_existing_index(index_name, self.embeddings_model)

    def get_index(self, index_name: str) -> Pinecone:
        return Pinecone.from_existing_index(index_name, self.embeddings_model)

    def search_similarity(self, index_name: str, query: str) -> list[Document]:
        docsearch = self.get_index(index_name)
        return docsearch.similarity_search(query)
