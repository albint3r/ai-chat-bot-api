from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException, status
from langchain_core.documents import Document
from langchain_openai import OpenAIEmbeddings

from src.domain.data_manager.schemas.schemas import RequestDocument
from src.infrastructure.chat_bot.pinecone_repository import PineconeRepository
from src.infrastructure.data_manager.cvs_docs_manager import CVSDocsManager

route = APIRouter(prefix='/data-manager',
                  tags=['Data Manager'], )


@route.post("/create-index/")
async def create_new_index(files: Annotated[list[str], Depends(CVSDocsManager.get_all_upload_files)], index_name: str):
    csv_docs_manager = CVSDocsManager(files_path=files, repo=PineconeRepository(), embeddings_model=OpenAIEmbeddings())
    csv_docs_manager.repo.init()
    response = csv_docs_manager.create_index(index_name)
    if response:
        return {"ok": 200}
    else:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST,
                            detail='Unexpected error happened in the Vector Server')


@route.post("/add-questions/")
async def post_new_questions(documents: list[RequestDocument], index_name: str):
    try:
        csv_docs_manager = CVSDocsManager(files_path=[], repo=PineconeRepository(), embeddings_model=OpenAIEmbeddings())
        csv_docs_manager.repo.init()
        new_documents = [Document(**doc.model_dump()) for doc in documents]
        csv_docs_manager.add_new_data(index_name, new_documents)
        return {"ok": 200}
    except Exception as e:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=f'Fatal Error: {e}')


@route.post("/upload-file/")
async def create_upload_file(response: Annotated[dict, Depends(CVSDocsManager.save_uploaded_file)]):
    return response
