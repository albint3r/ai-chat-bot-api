from icecream import ic

from src.domain.data_manager.schemas.schemas import RequestUserChatbotInfo
from src.domain.data_manager.use_case.i_data_manager_facade import IDataManagerFacade
from src.infrastructure.data_manager.data_manager_repository import DataManagerRepository


class DataMangerFacadeImpl(IDataManagerFacade):
    repo: DataManagerRepository

    def create_user_chatbot(self, chatbot_info: RequestUserChatbotInfo, user_id: str) -> None:
        self.repo.create_user_chatbot(user_id, chatbot_info.name, chatbot_info.index_name, chatbot_info.open_ai_api_key,
                                      chatbot_info.pinecone_api_key, chatbot_info.pinecone_environment,
                                      chatbot_info.description)

    def get_user_chatbots(self):
        pass

    def get_user_chatbot(self):
        pass

    def delete_user_chatbot(self):
        pass

    def update_user_chatbot(self):
        pass
