from abc import ABC, abstractmethod
from typing import Any

from langchain_core.runnables import RunnableSerializable
from pydantic import BaseModel

from src.domain.chat_bot.entities.answer import Answer
from src.domain.chat_bot.entities.question import Question


class IChatBot(BaseModel, ABC):
    class Config:
        arbitrary_types_allowed = True

    @abstractmethod
    def generate_chain(self, **kwargs) -> RunnableSerializable | RunnableSerializable[Any, str]:
        """This function return the response from the Question and Answer chatbot"""

    @abstractmethod
    def query_question(self, query: Question, **kwargs) -> Answer:
        """This function return the response from the Question and Answer chatbot"""

