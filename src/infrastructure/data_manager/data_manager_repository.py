from icecream import ic

from src.db.db import AbstractDB
from src.domain.chat_bot.errors.errors import DeleteChatBotError
from src.domain.data_manager.entities.user_chatbot import UserChatbot
from fastapi import HTTPException, status


class DataManagerRepository(AbstractDB):

    def create_user_chatbot(self, user_id: str, name: str, index_name: str, open_ai_api_key: str, pinecone_api_key: str,
                            pinecone_environment: str, description: str = "") -> None:
        query = "INSERT INTO chatbots (user_id, name, description, index_name, open_ai_api_key, pinecone_api_key, pinecone_environment) " \
                f"VALUES ('{user_id}', '{name}', '{description}', '{index_name}','{open_ai_api_key}', '{pinecone_api_key}'," \
                f" '{pinecone_environment}');"
        self.db.execute(query)

    def get_user_chatbots(self, user_id: str) -> list[UserChatbot]:
        try:
            query = f"SELECT * FROM chatbots WHERE user_id='{user_id}';"
            responses = self.db.query(query, fetch_all=True)
            if responses:
                return [UserChatbot(**response) for response in responses]
            return []
        except Exception as e:
            ic(f'Fatal Error: {e}')
            return []

    def get_user_chatbot(self, chatbot_id: str) -> UserChatbot:
        query = f"SELECT * FROM chatbots WHERE chatbot_id='{chatbot_id}';"
        response = self.db.query(query)
        if response:
            return UserChatbot(**response)

    def is_user_chatbot_owner(self, chatbot_id: str, user_id: str) -> UserChatbot:
        query = f"SELECT * FROM chatbots WHERE chatbot_id='{chatbot_id}' AND user_id='{user_id}';"
        response = self.db.query(query)
        if response:
            return UserChatbot(**response)
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,
                            detail='Error: The user is not owner of the chat.')

    def delete_user_chatbot(self, chatbot_id: str, user_id: str) -> None:
        try:
            query = (f"DELETE FROM chatbots WHERE chatbot_id= '{chatbot_id}' AND "
                     f"user_id='{user_id}';")
            self.db.execute(query)
        except Exception as _:
            raise DeleteChatBotError(f'You have an error deleting the current chatbot id: {chatbot_id}')

    def update_user_chatbot(self, chatbot_id: str, data: dict) -> None:
        try:
            update_fields = ', '.join([f"{key} = {self._format_value(value)}" for key, value in data.items()])
            query = f"UPDATE chatbots SET {update_fields} WHERE chatbot_id='{chatbot_id}';"
            self.db.execute(query)
        except Exception as e:
            raise HTTPException(status_code=status.HTTP_503_SERVICE_UNAVAILABLE, detail=f'Inexplicable error: {e}')

    def _format_value(self, value):
        if isinstance(value, bool):
            return str(value).lower()  # Convierte el valor booleano a minúsculas ('True' a 'true')
        else:
            return f"'{value}'"  # Envuelve otros tipos de datos en comillas simples
