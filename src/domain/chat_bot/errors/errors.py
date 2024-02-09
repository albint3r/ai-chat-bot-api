from fastapi import WebSocketException


class ErrorFormatIndexName(Exception):
    """Raise this error when the index name in Pinecone don't follow the next format:
    Can only contain lowercase letters, numbers, and hyphens."""


class NotExitingChatId(Exception):
    """The Provided ChatId don't exist"""


class ExistingConnectionError(WebSocketException):
    """Raise an Error When the websocket connection already exist"""


class ConnectionNotExist(WebSocketException):
    """Raise an Error When the websocket connection already exist"""


class ExistingConversationError(Exception):
    """Raise an error whe the user try to find an existed conversation"""


class CreateConversationError(Exception):
    """Raise an error whe the user try to create a conversation"""


class CreateMessageError(Exception):
    """Raise an error whe the user try to create a Message"""


class DeleteChatBotError(Exception):
    """Raise an error if it had problems when the user try to delete the chatbot"""
