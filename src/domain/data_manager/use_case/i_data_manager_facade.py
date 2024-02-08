from abc import ABC, abstractmethod

from pydantic import BaseModel

from src.domain.data_manager.entities.user_chatbot import UserChatbot


class IDataManagerFacade(BaseModel, ABC):

    @abstractmethod
    def get_user_chatbots(self, user_id: str) -> list[UserChatbot]:
        """Get a User Chatbots instance in the SQL Table"""

    @abstractmethod
    def get_user_chatbot(self, chatbot_id: str) -> UserChatbot:
        """Get a User Chatbot instance in the SQL Table"""

    @abstractmethod
    def delete_user_chatbot(self, user_id: str, chatbot_id: str, index_name: str, pinecone_api_key: str) -> None:
        """Delete a User Chatbot instance in the SQL Table"""

    @abstractmethod
    def update_user_chatbot(self, chatbot_id: str, data: dict) -> None:
        """Update Information a User Chatbot instance in the SQL Table"""
