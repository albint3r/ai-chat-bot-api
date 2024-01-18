from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException, status
from icecream import ic
from langchain_core.documents import Document
from langchain_openai import OpenAIEmbeddings

from src.db.db import db
from src.domain.data_manager.schemas.schemas import RequestDocument, RequestUserChatbotInfo
from src.infrastructure.auth.auth_handler_impl import auth_handler
from src.infrastructure.chat_bot.pinecone_repository import PineconeRepository
from src.infrastructure.data_manager.cvs_docs_manager import CVSDocsManager
from src.infrastructure.data_manager.data_manager_facade_impl import DataMangerFacadeImpl
from src.infrastructure.data_manager.data_manager_repository import DataManagerRepository

route = APIRouter(prefix='/data-manager',
                  tags=['Data Manager'], )


@route.post("/v1/create-index/")
async def create_new_index(files: Annotated[list[str], Depends(CVSDocsManager.get_all_upload_files)], index_name: str):
    csv_docs_manager = CVSDocsManager(files_path=files, repo=PineconeRepository(), embeddings_model=OpenAIEmbeddings())
    csv_docs_manager.repo.init()
    response = csv_docs_manager.create_index(index_name)
    if response:
        return {"ok": 200}
    else:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST,
                            detail='Unexpected error happened in the Vector Server')


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
async def upload_csv_file(data: Annotated[dict, Depends(CVSDocsManager.save_uploaded_file)]):
    chatbot_info, user_id = data
    files_path = CVSDocsManager.get_all_upload_files(user_id)
    ic(files_path)
    # facade = DataMangerFacadeImpl(repo=DataManagerRepository(db=db))
    # result = facade.create_user_chatbot(chatbot_info, user_id)
    return chatbot_info
