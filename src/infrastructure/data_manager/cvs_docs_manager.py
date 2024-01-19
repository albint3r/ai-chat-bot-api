import re
import shutil
from pathlib import Path

import pinecone
from fastapi import UploadFile, status
from fastapi.exceptions import HTTPException
from fastapi.responses import JSONResponse
from icecream import ic
from langchain_community.document_loaders import CSVLoader
from langchain_community.vectorstores.pinecone import Pinecone
from langchain_core.documents import Document

from src.domain.chat_bot.errors.errors import ErrorFormatIndexName
from src.domain.data_manager.use_case.i_docs_manager import IDocsManager

UPLOAD_FILES_PATH = "assets/uploads"


# Todo: Let's think how to refactor this tool to simplify . If is not possible let it like now.
class CVSDocsManager(IDocsManager):

    @staticmethod
    def save_uploaded_file(file: UploadFile, user_id: str) -> None:
        try:
            user_folder = Path(UPLOAD_FILES_PATH) / user_id
            # Verificar si la carpeta de destino para el usuario existe, si no, créala.
            user_folder.mkdir(parents=True, exist_ok=True)
            # Guardar el archivo en la carpeta de destino para el usuario.
            file_path = user_folder / file.filename
            with file_path.open("wb") as buffer:
                shutil.copyfileobj(file.file, buffer)

        except Exception:
            raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail='It was an error uploading the file.')

    @staticmethod
    def get_all_upload_files(user_id: str, file_path: str | None = UPLOAD_FILES_PATH) -> list[str]:
        try:
            user_folder = Path(file_path) / user_id
            files = [str(user_folder / archivo.name) for archivo in user_folder.glob("*")]
            if files:
                return files
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f'No files in user [{user_id}] directory')
        except Exception as e:
            raise HTTPException(status_code=status.HTTP_409_CONFLICT,
                                detail=f"Error at the moment to load files: {str(e)}")

    @staticmethod
    def delete_user_folder(user_id: str, file_path: str | None = UPLOAD_FILES_PATH):
        try:
            user_folder = Path(file_path) / user_id
            shutil.rmtree(user_folder)
            return JSONResponse(content={"message": f"User [{user_id}] folder deleted successfully"})
        except FileNotFoundError:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f'User [{user_id}] not found')
        except Exception as e:
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                                detail=f"Error deleting user [{user_id}] folder: {str(e)}")

    def _get_documents_text(self, documents: list[Document], size: int = 2) -> list[str]:
        return [documents[i].page_content for i in range(size)]

    def load_files(self, files_path: list[str] | None = None, encoding='utf-8') -> list[Document]:
        # Update the files property
        self.files_path = files_path if files_path else self.files_path
        documents = []
        for file_path in self.files_path:
            loader = CSVLoader(file_path=file_path, encoding=encoding,
                               # metadata_columns=['question', 'category', 'answer'],
                               )
            if not documents:
                documents = loader.load()
                continue
            documents.extend(loader.load())
        return documents

    def add_new_data(self, index_name: str, new_documents: list[Document]) -> None:
        self.repo.init()
        vectorstore = self.repo.get_vectorstore(index_name, self.embeddings_model, "text")
        documents = self._get_documents_text(new_documents, size=len(new_documents))
        ic(f'Adding new documents question to index: {index_name}')
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
        if not self._validate_index_name(index_name):
            raise ErrorFormatIndexName('Can only contain lowercase letters, numbers, and hyphens.')
        return Pinecone.from_existing_index(index_name, self.embeddings_model)

    def search_similarity(self, index_name: str, query: str) -> list[Document]:
        docsearch = self.get_index(index_name)
        return docsearch.similarity_search(query)
