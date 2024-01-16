from datetime import datetime, timedelta

import bcrypt
import jwt
from fastapi import HTTPException, status, Security
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer

from credentials_provider import credentials_provider
from src.domain.auth.use_case.i_auth_handler import IAuthHandler

encode = "utf-8"


class _AuthHandlerImpl(IAuthHandler):
    security: HTTPBearer = HTTPBearer()
    secret: str = credentials_provider.secret
    algorithm: str = 'HS256'

    def get_password_hash(self, password: str) -> bytes:
        return bcrypt.hashpw(password.encode(encode), bcrypt.gensalt())

    def verify_password(self, password: str, hashed_password: bytes | str) -> bool:
        return bcrypt.checkpw(password.encode(encode), hashed_password)

    def encode_token(self, user_id: str) -> str:
        payload = {
            'exp': datetime.utcnow() + timedelta(days=1, minutes=0),
            'iat': datetime.utcnow(),
            'sub': user_id
        }
        return jwt.encode(
            payload,
            self.secret,
            algorithm=self.algorithm
        )

    def decode_token(self, token_session: str) -> str:
        try:
            payload = jwt.decode(token_session, self.secret, algorithms=self.algorithm)
            return payload.get('sub')
        except jwt.ExpiredSignatureError:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail='Signature Expired')
        except jwt.InvalidTokenError:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail='Invalide token')

    def auth_wrapper(self, auth: HTTPAuthorizationCredentials = Security(security)) -> str:
        return self.decode_token(auth.credentials)


auth_handler = _AuthHandlerImpl()
