from pinecone import Index

from credentials_provider import credentials_provider
from src.domain.chat_bot.repositories.i_vectors_repository import IVectorRepository
import pinecone


class PineconeRepository(IVectorRepository):

    def init(self) -> None:
        pinecone.init(api_key=credentials_provider.pinecone_ai_api_key,
                      environment='asia-southeast1-gcp')

    def get(self, index_name: str) -> Index:
        return pinecone.Index(index_name)

    def create(self, index_name: str, dimension=1536, metric='cosine') -> None:
        pinecone.create_index(name=index_name, dimension=dimension, metric=metric)
