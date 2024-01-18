from icecream import ic

from src.db.db import AbstractDB


class DataManagerRepository(AbstractDB):

    def create_user_chatbot(self, user_id: str, name: str, index_name: str, open_ai_api_key: str, pinecone_api_key: str,
                            pinecone_environment: str, description: str = "") -> None:
        query = "INSERT INTO chatbots (user_id, name, description, index_name, open_ai_api_key, pinecone_api_key, pinecone_environment) " \
                f"VALUES ('{user_id}', '{name}', '{description}', '{index_name}','{open_ai_api_key}', '{pinecone_api_key}'," \
                f" '{pinecone_environment}');"
        self.db.execute(query)

    def get_user_chatbots(self):
        pass

    def get_user_chatbot(self):
        pass

    def delete_user_chatbot(self):
        pass

    def update_user_chatbot(self):
        pass
