from fastapi import WebSocketException


class ErrorFormatIndexName(Exception):
    """Raise this error when the index name in Pinecone don't follow the next format:
    Can only contain lowercase letters, numbers, and hyphens."""


class ExistingConnectionError(WebSocketException):
    """Raise an Error When the websocket connection already exist"""


class ConnectionNotExist(WebSocketException):
    """Raise an Error When the websocket connection already exist"""
