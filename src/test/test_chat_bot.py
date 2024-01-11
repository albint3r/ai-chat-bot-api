import pytest
from langchain_openai import OpenAIEmbeddings
from src.domain.chat_bot.entities.answer import Answer
from src.domain.chat_bot.entities.question import Question
from src.infrastructure.chat_bot.chatbot import ChatBotX
from src.infrastructure.chat_bot.pinecone_repository import PineconeRepository
from credentials_provider import credentials_provider

test_index_name = 'tobecv'


class TestChatBot:

    @pytest.fixture
    def chatbot(self) -> ChatBotX:
        return ChatBotX(index_name=test_index_name, repo=PineconeRepository(),
                        embeddings_model=OpenAIEmbeddings(openai_api_key=credentials_provider.open_ai_api_key))

    def test_chatbot_queries(self, chatbot: ChatBotX):
        question = Question(text='¿Que proyectos tienes en flutter?')
        expected = True
        answer = chatbot.query_question(question)
        result = isinstance(answer, Answer)
        error_msg = f'2-Error: Expect -> <{expected}>. Result -> <{result}>'
        assert expected is result, error_msg
