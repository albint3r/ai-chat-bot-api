from abc import ABC, abstractmethod
from typing import Any, Dict

from pydantic import BaseModel
from fastapi import WebSocket

TChatConnections = Dict[str, WebSocket]


class IWebSocketManager(BaseModel, ABC):
    chat_connections: TChatConnections = {}

    class Config:
        arbitrary_types_allowed = True

    @abstractmethod
    async def connect(self, websocket: WebSocket, chat_id: str) -> None:
        """Connect with a new chanel"""

    @abstractmethod
    async def disconnect(self, websocket: WebSocket) -> None:
        """Disconnect from chanel"""

    @abstractmethod
    async def brod_cast(self, message_json: dict[str, Any]) -> None:
        """Send message for all the user"""

    @abstractmethod
    async def brod_cast_user(self, message_json: dict[str, Any], chat_id: str) -> None:
        """Send message for a specific user id"""
