import pytest
from langchain_community.vectorstores.pinecone import Pinecone
from langchain_openai import OpenAIEmbeddings

from credentials_provider import credentials_provider
from src.domain.chat_bot.errors.errors import ErrorFormatIndexName
from src.infrastructure.chat_bot.cvs_docs_manager import CVSDocsManager
from src.infrastructure.chat_bot.pinecone_repository import PineconeRepository
import pinecone
from icecream import ic


class TestAddNewQuestions:
    @pytest.fixture
    def manager(self) -> CVSDocsManager:
        return CVSDocsManager(files_path=['assets/QA-Tobe-Experience.csv'],
                              repo=PineconeRepository(),
                              embeddings_model=OpenAIEmbeddings(openai_api_key=credentials_provider.open_ai_api_key))

    def test_load_new_files(self, manager: CVSDocsManager):
        """Test CV add correctly a new CSV Questions file"""
        documents = manager.load_files(['assets/QA-Tobe-Experience.csv'])
        result = len(documents)
        expected = 81
        error_msg = f'1-Error: Expecte {expected}. Result: {result}'
        assert expected == result, error_msg
        # Todo: This would add the new files:
        # manager.add_new_data('tobecv', documents)
        # manager.create_index('tobecv')
