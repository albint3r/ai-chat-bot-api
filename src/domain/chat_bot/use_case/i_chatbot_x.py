from abc import ABC, abstractmethod

from pydantic import BaseModel, validate_call

from src.domain.chat_bot.entities.answer import Answer
from src.domain.chat_bot.entities.question import Question
from langchain_core.runnables import RunnablePassthrough, RunnableSerializable
from typing import Any


class IChatBot(BaseModel, ABC):
    @validate_call
    @abstractmethod
    def generate_chain(self) -> RunnableSerializable | RunnableSerializable[Any, str]:
        """This function return the response from the Question and Answer chatbot"""

    @validate_call
    @abstractmethod
    def query_question(self, query: Question) -> Answer:
        """This function return the response from the Question and Answer chatbot"""