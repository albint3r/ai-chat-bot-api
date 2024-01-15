from typing import Any

from fastapi import WebSocket
from fastapi import status
from icecream import ic

from src.domain.chat_bot.errors.errors import ExistingConnectionError
from src.domain.chat_bot.use_case.i_websocket_manager import IWebSocketManager


class ChatConnectionManager(IWebSocketManager):
    """For more information of the implementation:
    https://stackoverflow.com/questions/77525528/fastapi-websockets-multiple-connections-for-one-client"""

    async def connect(self, websocket: WebSocket, chat_id: str) -> None:
        existing_connections = self.chat_connections.get(chat_id)
        if existing_connections:
            await websocket.close()
            raise ExistingConnectionError(code=status.WS_1008_POLICY_VIOLATION,
                                          reason='Error: Connection already exist')
        await websocket.accept()
        # Create new attribute on the websocket class.
        # This hold the user id to latter find him much easier
        websocket.chat_id = chat_id
        self.chat_connections[chat_id] = websocket
        ic(f'New connection from the user: {chat_id} is establish with the server')

    async def disconnect(self, websocket: WebSocket) -> None:
        chat_id = getattr(websocket, 'chat_id', None)
        # Get chat_id connection or None
        if chat_id in self.chat_connections:
            del self.chat_connections[chat_id]

    async def brod_cast(self, message_json: dict[str, Any]) -> None:
        for chat_connection in self.chat_connections.values():
            await chat_connection.send_json(message_json)

    async def brod_cast_user(self, message_json: dict[str, Any], chat_id: str) -> None:
        matching_chat_connection = self.chat_connections.get(chat_id)
        if matching_chat_connection:
            await matching_chat_connection.send_json(message_json)


chat_connection_manager = ChatConnectionManager()
