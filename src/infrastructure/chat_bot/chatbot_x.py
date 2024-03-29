from typing import Any

from icecream import ic
from langchain_community.vectorstores import Pinecone
from langchain_core.documents import Document
from langchain_core.embeddings import Embeddings
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import PromptTemplate
from langchain_core.runnables import RunnablePassthrough, RunnableSerializable
from langchain_openai import ChatOpenAI, OpenAIEmbeddings

from credentials_provider import credentials_provider
from src.db.db import db
from src.domain.chat_bot.entities.answer import Answer
from src.domain.chat_bot.entities.question import Question
from src.domain.chat_bot.repositories.i_vectors_repository import IVectorRepository
from src.domain.chat_bot.use_case.i_chatbot_x import IChatBot
from src.infrastructure.auth.auth_repository import AuthRepository
from src.infrastructure.chat_bot.pinecone_repository import PineconeRepository


class ChatBotX(IChatBot):
    repo: IVectorRepository
    embeddings_model: Embeddings | None = None
    index_name: str
    template: str = """Use the following pieces of context to answer the question at the end.
    If you don't know the answer, just say that you don't know, don't try to make up an answer.
    Use three sentences maximum and keep the answer as concise as possible.
    Always say "thanks for asking!" at the end of the answer.

    {context}

    Question: {question}

    Helpful Answer:"""

    class Config:
        arbitrary_types_allowed = True

    def _format_docs(self, documents: list[Document]) -> str:
        return "\n\n".join(doc.page_content for doc in documents)

    def generate_chain(self, llm) -> RunnableSerializable | RunnableSerializable[Any, str]:
        # Init Pinecone db
        # Verify is not home
        self.repo.init()
        # Todo: Add a class that wrap the vector store object:
        index = self.repo.get(self.index_name)
        vectorstore = Pinecone(index, self.embeddings_model, "text")
        # Get retrievers
        retriever = vectorstore.as_retriever()
        custom_prompt = PromptTemplate.from_template(self.template)
        return (
                {"context": retriever | self._format_docs, "question": RunnablePassthrough()}
                | custom_prompt
                | llm
                | StrOutputParser()
        )

    def query_question(self, query: Question, llm) -> Answer:
        chain = self.generate_chain(llm=llm)
        response = chain.invoke(query.text)
        return Answer(text=response)
