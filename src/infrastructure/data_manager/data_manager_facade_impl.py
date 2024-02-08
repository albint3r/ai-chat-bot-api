from fastapi import Depends, HTTPException, status
from fastapi import UploadFile
from langchain_openai import OpenAIEmbeddings

from src.db.db import db
from src.domain.data_manager.entities.user_chatbot import UserChatbot
from src.domain.data_manager.schemas.schemas import RequestUserChatbotInfo, RequestChatBotActivateStatus
from src.domain.data_manager.use_case.i_data_manager_facade import IDataManagerFacade
from src.infrastructure.auth.auth_handler_impl import auth_handler
from src.infrastructure.chat_bot.pinecone_repository import PineconeRepository
from src.infrastructure.data_manager.cvs_docs_manager import CVSDocsManager
from src.infrastructure.data_manager.data_manager_repository import DataManagerRepository


class DataMangerFacadeImpl(IDataManagerFacade):
    repo: DataManagerRepository

    def create_new_index_from_csv(self, file: UploadFile,
                                  chatbot_info: RequestUserChatbotInfo = Depends(RequestUserChatbotInfo),
                                  user_id: str = Depends(auth_handler.auth_wrapper)):
        try:
            CVSDocsManager.save_uploaded_file(file, user_id)
            files_path = CVSDocsManager.get_all_upload_files(user_id)
            pinecone_repo = PineconeRepository(api_key=chatbot_info.pinecone_api_key,
                                               environment=chatbot_info.pinecone_environment)
            embeddings = OpenAIEmbeddings(openai_api_key=chatbot_info.open_ai_api_key)

            csv_docs_manager = CVSDocsManager(files_path=files_path, repo=pinecone_repo, embeddings_model=embeddings)
            csv_docs_manager.repo.init()
            response = csv_docs_manager.create_index(chatbot_info.index_name)
            self._create_user_chatbot(chatbot_info, user_id)
            csv_docs_manager.delete_user_folder(user_id)
            if response:
                return {"ok": 200}
        except Exception as e:
            raise HTTPException(status_code=status.HTTP_409_CONFLICT,
                                detail=f'Pinecone have an error creating the Vector Index.: {e}')

    def _create_user_chatbot(self, chatbot_info: RequestUserChatbotInfo, user_id: str) -> None:
        self.repo.create_user_chatbot(user_id, chatbot_info.name, chatbot_info.index_name,
                                      chatbot_info.open_ai_api_key,
                                      chatbot_info.pinecone_api_key, chatbot_info.pinecone_environment,
                                      chatbot_info.description)

    def get_user_chatbots(self, user_id: str = Depends(auth_handler.auth_wrapper)) -> list[UserChatbot]:
        return self.repo.get_user_chatbots(user_id)

    def get_user_chatbot(self, chatbot_id: str) -> UserChatbot:
        return self.repo.get_user_chatbot(chatbot_id)

    def delete_user_chatbot(self, user_id: str, chatbot_id: str, index_name: str, pinecone_api_key: str) -> None:
        pinecone_repo = PineconeRepository()
        self.repo.delete_user_chatbot(chatbot_id, user_id)
        pinecone_repo.delete(index_name, pinecone_api_key)

    def update_user_chatbot(self, chatbot_id: str, data: dict):
        self.repo.update_user_chatbot(chatbot_id, data)

    def update_user_chatbot_activate_status(self, chabot_status: RequestChatBotActivateStatus):
        try:
            data = chabot_status.model_dump()
            data.pop('chatbot_id')
            self.update_user_chatbot(chabot_status.chatbot_id, data)
            return {'ok': 200}
        except Exception as e:
            return {'error': e}


data_manager = DataMangerFacadeImpl(repo=DataManagerRepository(db=db))
