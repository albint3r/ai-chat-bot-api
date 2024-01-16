from fastapi.security import HTTPAuthorizationCredentials
from pydantic import BaseModel, validate_call
from abc import ABC, abstractmethod


class IAuthHandler(ABC, BaseModel):
    class Config:
        arbitrary_types_allowed = True

    @abstractmethod
    @validate_call()
    def get_password_hash(self, password: str) -> bytes:
        """Receive a plain text password and hashed."""

    @abstractmethod
    @validate_call()
    def verify_password(self, password: str, hashed_password: bytes) -> bool:
        """Verify if the password is the same has the hashed password"""

    @abstractmethod
    @validate_call()
    def encode_token(self, user_id: str) -> str:
        """Create an encode token for the user."""

    @abstractmethod
    @validate_call()
    def decode_token(self, token_id: str) -> int:
        """Decode the user token"""

    @abstractmethod
    def auth_wrapper(self, auth: HTTPAuthorizationCredentials) -> int:
        """Is the auth handler to the routers"""
