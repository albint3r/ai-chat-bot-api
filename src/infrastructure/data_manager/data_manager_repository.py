from src.db.db import AbstractDB
from src.domain.data_manager.entities.user_chatbot import UserChatbot


class DataManagerRepository(AbstractDB):

    def create_user_chatbot(self, user_id: str, name: str, index_name: str, open_ai_api_key: str, pinecone_api_key: str,
                            pinecone_environment: str, description: str = "") -> None:
        query = "INSERT INTO chatbots (user_id, name, description, index_name, open_ai_api_key, pinecone_api_key, pinecone_environment) " \
                f"VALUES ('{user_id}', '{name}', '{description}', '{index_name}','{open_ai_api_key}', '{pinecone_api_key}'," \
                f" '{pinecone_environment}');"
        self.db.execute(query)

    def get_user_chatbots(self, user_id: str) -> list[UserChatbot]:
        query = f"SELECT * FROM chatbots WHERE user_id='{user_id}';"
        responses = self.db.query(query, fetch_all=True)
        if responses:
            return [UserChatbot(**response) for response in responses]
        return []

    def get_user_chatbot(self, chatbot_id: str) -> UserChatbot:
        query = f"SELECT * FROM chatbots WHERE chatbot_id='{chatbot_id}';"
        response = self.db.query(query)
        if response:
            return UserChatbot(**response)

    def delete_user_chatbot(self, chatbot_id: str) -> None:
        query = f"DELETE FROM chatbots WHERE chatbot_id='{chatbot_id}';"
        self.db.execute(query)

    def update_user_chatbot(self, chatbot_id: str, data: dict) -> None:
        update_fields = ', '.join([f"{key} = '{value}'" for key, value in data.items()])
        query = f"UPDATE chatbots SET {update_fields} WHERE chatbot_id='{chatbot_id}';"
        self.db.execute(query)
