from fastapi import HTTPException, status

from src.domain.auth.schemas.schemas import SchemaSignin, SchemaLogIn
from src.domain.auth.use_case.i_auth_facade import IAuthFacade
from src.domain.auth.use_case.i_auth_handler import IAuthHandler
from src.infrastructure.repositories.auth.auth_repository import AuthRepository


class AuthFacadeImpl(IAuthFacade):
    repo: AuthRepository

    def signin(self, email: str, password: str, auth_handler: IAuthHandler) -> SchemaSignin:
        user = self.repo.get_user(email)
        # If user don't exist created
        if not user:
            hash_password = auth_handler.get_password_hash(password)
            # Create new user with Hash Password
            # Convert the bytecode password into a string
            self.repo.create_user(email, hash_password.decode('utf-8'))

        # Check user hash password
        return self.login(email, password, auth_handler)

    def login(self, email: str, password: str, auth_handler: IAuthHandler) -> SchemaLogIn:
        user = self.repo.get_user(email)
        # Convert String into bytecodes to very the password
        # without this the method have error.
        if not user:
            raise HTTPException(
                status_code=status.HTTP_409_CONFLICT,
                detail='User or Password have error.'
            )

        hash_password = user.password.get_secret_value().encode("utf-8")
        # [Error] if not user or the password verification fail
        if not user or not auth_handler.verify_password(password, hash_password):
            raise HTTPException(
                status_code=status.HTTP_409_CONFLICT,
                detail='User or Password have error.'
            )
        session_token = auth_handler.encode_token(user.user_id)
        return SchemaLogIn(user=user, session_token=session_token)

    def login_from_session_token(self, user_id: str, auth_handler: IAuthHandler) -> SchemaLogIn:
        user = self.repo.get_user_by_id(user_id)
        session_token = auth_handler.encode_token(user.user_id)
        return SchemaLogIn(user=user, session_token=session_token)
