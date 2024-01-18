from pydantic import BaseModel
from abc import ABC, abstractmethod

from src.domain.data_manager.schemas.schemas import RequestUserChatbotInfo


class IDataManagerFacade(BaseModel, ABC):

    @abstractmethod
    def create_user_chatbot(self, chatbot_info: RequestUserChatbotInfo, user_id: str):
        """Create a User Chatbot instance in the SQL Table"""

    @abstractmethod
    def get_user_chatbots(self):
        """Get a User Chatbots instance in the SQL Table"""

    @abstractmethod
    def get_user_chatbot(self):
        """Get a User Chatbot instance in the SQL Table"""

    @abstractmethod
    def delete_user_chatbot(self):
        """Delete a User Chatbot instance in the SQL Table"""

    @abstractmethod
    def update_user_chatbot(self):
        """Update Information a User Chatbot instance in the SQL Table"""
