from pydantic import BaseModel, EmailStr, SecretStr, Field
from fastapi import status

from src.domain.auth.entities.user import User


class SchemaSignin(BaseModel):
    """Schema SignIn Responses"""
    user: User
    session_token: str
    status_code: int = status.HTTP_201_CREATED


class SchemaLogIn(SchemaSignin):
    """Schema Login Responses"""
    status_code: int = status.HTTP_202_ACCEPTED


class AuthEmailRequest(BaseModel):
    email: EmailStr = Field(exclude=True)
    password: SecretStr = Field(exclude=True)
