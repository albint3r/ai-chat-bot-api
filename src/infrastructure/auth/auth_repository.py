from src.db.db import AbstractDB
from pydantic import validate_call

from src.domain.auth.entities.user import User
from src.domain.chat_bot.errors.errors import NotExitingChatId
from src.domain.data_manager.entities.user_chatbot import UserChatbot


class AuthRepository(AbstractDB):
    """Authenticated repository"""

    @validate_call()
    def get_user(self, email) -> User | None:
        """Get the user from the database"""
        query = f'SELECT * FROM users WHERE email="{email}";'
        result = self.db.query(query)
        if result:
            return User(**result)

    @validate_call()
    def get_user_by_id(self, user_id) -> User | None:
        """Get the user from the database"""
        query = f'SELECT * FROM users WHERE user_id="{user_id}";'
        result = self.db.query(query)
        if result:
            return User(**result)

    @validate_call()
    def create_user(self, email: str, password: str | bytes) -> None:
        """Get the user from the database"""
        query = f"INSERT INTO users (email, password) VALUES ('{email}', '{password}')"
        self.db.execute(query)

    @validate_call()
    def delete_user(self, user_id: str) -> None:
        """Get the user from the database"""
        query = f"DELETE FROM users WHERE user_id='{user_id}';"
        self.db.execute(query)

    @validate_call()
    def get_user_chatbot(self, chat_id: str) -> UserChatbot:
        """Get the user from the database"""
        query = f"SELECT * FROM chatbots WHERE chatbot_id='{chat_id}';"
        result = self.db.query(query)
        if result:
            return UserChatbot(**result)
        raise NotExitingChatId(f'The Chat Id: {chat_id} provided dont exit')
