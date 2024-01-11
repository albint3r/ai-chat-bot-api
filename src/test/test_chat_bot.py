import pytest

from src.domain.chat_bot.entities.answer import Answer
from src.domain.chat_bot.entities.question import Question
from src.infrastructure.chat_bot.chatbot import ChatBotX

test_index_name = 'tobecv'


class TestChatBot:

    @pytest.fixture
    def chatbot(self) -> ChatBotX:
        return ChatBotX(index_name=test_index_name)

    def test_chatbot_queries(self, chatbot: ChatBotX):
        question = Question(text='¿Que proyectos tienes en flutter?')
        expected = True
        answer = chatbot.query_question(question)
        result = isinstance(answer, Answer)
        error_msg = f'2-Error: Expect -> <{expected}>. Result -> <{result}>'
        assert expected is result, error_msg
