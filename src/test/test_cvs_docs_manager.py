import pytest
from langchain_community.vectorstores.pinecone import Pinecone
from langchain_openai import OpenAIEmbeddings

from credentials_provider import credentials_provider
from src.domain.chat_bot.errors.errors import ErrorFormatIndexName
from src.infrastructure.chat_bot.cvs_docs_manager import CVSDocsManager
from src.infrastructure.chat_bot.pinecone_repository import PineconeRepository
import pinecone


class TestCVSDocsManager:
    @pytest.fixture
    def manager(self) -> CVSDocsManager:
        return CVSDocsManager(files_path=['assets/QA-Test-file.csv'],
                              repo=PineconeRepository(),
                              embeddings_model=OpenAIEmbeddings(openai_api_key=credentials_provider.open_ai_api_key))

    def test_loader(self, manager: CVSDocsManager):
        """Test if the class load correctly the list files"""
        expected = 2
        documents = manager.load_files()
        result = len(documents)
        error_msg = f'Error: Expect -> <{expected}>. Result -> <{result}>'
        assert expected == result, error_msg

    def test_create_new_index(self, manager: CVSDocsManager):
        """Test if the Vector DB create a new index correctly"""
        test_index_name = 'test'
        # Initialize pinecone instance
        pinecone.init(api_key=credentials_provider.pinecone_ai_api_key,
                      environment='asia-southeast1-gcp')
        # Validate index dont' exist in vector db.
        expected = False
        result = test_index_name in pinecone.list_indexes()
        error_msg = f'1-Error: Expect -> <{expected}>. Result -> <{result}>'
        assert expected is result, error_msg
        # Create index in Pinecone
        manager.create_index(index_name=test_index_name)
        expected = True
        result = test_index_name in pinecone.list_indexes()
        error_msg = f'2-Error: Expect -> <{expected}>. Result -> <{result}>'
        assert expected is result, error_msg

    def test_get_index(self, manager: CVSDocsManager):
        test_index_name = 'test'
        index = manager.get_index(index_name=test_index_name)
        expected = True
        result = isinstance(index, Pinecone)
        error_msg = f'1-Error: Expect -> <{expected}>. Result -> <{result}>'
        assert expected is result, error_msg
        # Delete the new index created:
        pinecone.delete_index(test_index_name)

    def test_error_index_bad_name(self, manager: CVSDocsManager):
        with pytest.raises(ErrorFormatIndexName, match='Can only contain lowercase letters, numbers, and hyphens.'):
            test_index_name = 'testNotUpperNameLetterError'
            manager.create_index(index_name=test_index_name)
