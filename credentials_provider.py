from typing import Optional, Dict

from dotenv import dotenv_values
from pydantic import BaseModel


class _CredentialsProvider(BaseModel):
    env: Dict[str, Optional[str]] = dotenv_values(".env")

    @property
    def open_ai_api_key(self) -> str:
        return self.env.get('OPENAI_API_KEY')

    @property
    def pinecone_ai_api_key(self) -> str:
        return self.env.get('PINECONE_API_KEY')

    @property
    def user(self) -> str:
        return self.env.get('USER')

    @property
    def password(self) -> str:
        return self.env.get('PASSWORD')

    @property
    def secret(self) -> str:
        return self.env.get('SECRET')


credentials_provider = _CredentialsProvider()
