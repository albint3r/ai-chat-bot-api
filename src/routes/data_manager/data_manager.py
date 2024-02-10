from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException, status
from langchain_core.documents import Document
from langchain_openai import OpenAIEmbeddings

from src.db.db import db
from src.domain.data_manager.entities.user_chatbot import UserChatbot
from src.domain.data_manager.schemas.schemas import RequestDocument, SchemaDeleteUserChatbot
from src.infrastructure.auth.auth_handler_impl import auth_handler
from src.infrastructure.chat_bot.pinecone_repository import PineconeRepository
from src.infrastructure.data_manager.cvs_docs_manager import CVSDocsManager
from src.infrastructure.data_manager.data_manager_facade_impl import data_manager
from src.infrastructure.data_manager.data_manager_repository import DataManagerRepository

route = APIRouter(prefix='/data-manager',
                  tags=['Data Manager'], )


@route.post("/v1/add-questions")
async def post_new_questions(documents: list[RequestDocument],
                             data: SchemaDeleteUserChatbot,
                             user_id: str = Depends(auth_handler.auth_wrapper)):
    repo = DataManagerRepository(db=db)
    chatbot_info = repo.is_user_chatbot_owner(data.chatbot_id, user_id)
    try:
        csv_docs_manager = CVSDocsManager(files_path=[],
                                          repo=PineconeRepository(api_key=data.pinecone_api_key,
                                                                  environment=data.pinecone_environment),
                                          embeddings_model=OpenAIEmbeddings(
                                              openai_api_key=chatbot_info.open_ai_api_key))
        new_documents = [Document(**doc.model_dump()) for doc in documents]
        csv_docs_manager.add_new_data(data.index_name, new_documents)
        return {"ok": 200}
    except Exception as e:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=f'Fatal Error: {e}')


@route.post("/v1/upload-file/csv/")
async def upload_csv_file(data: Annotated[dict, Depends(data_manager.create_new_index_from_csv)]):
    return data


@route.get("/v1/user/chat-bots/")
async def get_user_chatbots(data: list[UserChatbot] = Depends(data_manager.get_user_chatbots)) -> list[UserChatbot]:
    return data


@route.put("/v1/user/chat-bots/active/")
async def update_chatbot_to_activate_or_desactivate(
        ok=Depends(data_manager.update_user_chatbot_activate_status), _: str = Depends(auth_handler.auth_wrapper)):
    try:
        return ok
    except Exception as e:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail=f'Error updating the chatbot status: {e}')


@route.delete("/v1/delete/chatbot")
async def delete_user_chatbot(data: SchemaDeleteUserChatbot, user_id: str = Depends(auth_handler.auth_wrapper)):
    data_manager.delete_user_chatbot(user_id, data)
