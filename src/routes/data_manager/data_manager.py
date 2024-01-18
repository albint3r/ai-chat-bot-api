from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException, status
from langchain_core.documents import Document
from langchain_openai import OpenAIEmbeddings

from src.domain.data_manager.schemas.schemas import RequestDocument
from src.infrastructure.chat_bot.pinecone_repository import PineconeRepository
from src.infrastructure.data_manager.cvs_docs_manager import CVSDocsManager
from src.infrastructure.data_manager.data_manager_facade_impl import data_mangar_facade_impl

route = APIRouter(prefix='/data-manager',
                  tags=['Data Manager'], )


@route.post("/v1/add-questions/")
async def post_new_questions(documents: list[RequestDocument], index_name: str):
    try:
        csv_docs_manager = CVSDocsManager(files_path=[], repo=PineconeRepository(), embeddings_model=OpenAIEmbeddings())
        csv_docs_manager.repo.init()
        new_documents = [Document(**doc.model_dump()) for doc in documents]
        csv_docs_manager.add_new_data(index_name, new_documents)
        return {"ok": 200}
    except Exception as e:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=f'Fatal Error: {e}')


@route.post("/v1/upload-file/csv/")
async def upload_csv_file(data: Annotated[dict, Depends(data_mangar_facade_impl.create_new_index_from_csv)]):
    return data
