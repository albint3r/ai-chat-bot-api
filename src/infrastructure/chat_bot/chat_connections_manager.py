from typing import Any

from icecream import ic
from starlette.websockets import WebSocket

from src.domain.chat_bot.errors.errors import ExistingConnectionError
from src.domain.chat_bot.use_case.i_websocket_manager import IWebSocketManager
from fastapi import WebSocketException, status


class ChatConnectionManager(IWebSocketManager):

    async def connect(self, websocket: WebSocket, user_id: str) -> None:
        existing_connections = self.chat_connections.get(user_id)
        if existing_connections:
            await websocket.close()
            raise ExistingConnectionError(code=status.WS_1008_POLICY_VIOLATION,
                                          reason='Error: Connection already exist')
        await websocket.accept()
        # Create new attribute on the websocket class.
        # This hold the user id to latter find him much easier
        websocket.user_id = user_id
        self.chat_connections[user_id] = websocket
        ic(f'New connection from the user: {user_id} is establish with the server')

    async def disconnect(self, websocket: WebSocket) -> None:
        user_id = getattr(websocket, 'user_id', None)  # Get user_id connection or None
        if user_id in self.chat_connections:
            await websocket.close()
            del self.chat_connections[user_id]

    async def brod_cast(self, message_json: dict[str, Any], user_id: str) -> None:
        for chat_connection in self.chat_connections.values():
            await chat_connection.send_json(message_json)

    async def brod_cast_user(self, message_json: dict[str, Any], user_id: str) -> None:
        matching_chat_connection = self.chat_connections.get(user_id)
        if matching_chat_connection:
            await matching_chat_connection.send_json(message_json)


chat_connection_manager = ChatConnectionManager()
