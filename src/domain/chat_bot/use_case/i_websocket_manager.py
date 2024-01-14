from abc import ABC, abstractmethod
from typing import Any, Dict

from pydantic import BaseModel
from starlette.websockets import WebSocket

TChatConnections = Dict[str, WebSocket]


class IWebSocketManager(BaseModel, ABC):
    chat_connections: TChatConnections = {}

    @abstractmethod
    async def connect(self, websocket: WebSocket, user_id: str) -> None:
        """Connect with a new chanel"""

    @abstractmethod
    async def disconnect(self, websocket: WebSocket) -> None:
        """Disconnect from chanel"""

    @abstractmethod
    async def brod_cast(self, message_json: dict[str, Any], user_id: str) -> None:
        """Send message for all the user"""

    @abstractmethod
    async def brod_cast_user(self, message_json: dict[str, Any], user_id: str) -> None:
        """Send message for a specific user id"""
