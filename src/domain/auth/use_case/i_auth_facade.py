from pydantic import BaseModel, validate_call
from abc import ABC, abstractmethod

from src.domain.auth.schemas.schemas import SchemaSignin, SchemaLogIn
from src.domain.auth.use_case.i_auth_handler import IAuthHandler


class IAuthFacade(BaseModel, ABC):

    @abstractmethod
    @validate_call()
    def signin(self, email: str, password: str, auth_handler: IAuthHandler) -> SchemaSignin:
        """Create a new user in the database."""

    @abstractmethod
    @validate_call()
    def login(self, email: str, password: str, auth_handler: IAuthHandler) -> SchemaLogIn:
        """ Log the user in their account."""

    @abstractmethod
    @validate_call()
    def login_from_session_token(self, user_id: str, auth_handler: IAuthHandler) -> SchemaLogIn:
        """ Log from the session token. This happens when the user return to their account."""
