from typing import Any

import pinecone
from langchain_community.vectorstores import Pinecone
from langchain_core.documents import Document
from langchain_core.embeddings import Embeddings
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import PromptTemplate
from langchain_core.runnables import RunnablePassthrough, RunnableSerializable
from langchain_openai import ChatOpenAI
from langchain_openai import OpenAIEmbeddings

from credentials_provider import credentials_provider
from src.domain.chat_bot.entities.answer import Answer
from src.domain.chat_bot.entities.question import Question
from src.domain.chat_bot.repositories.i_vectors_repository import IVectorRepository
from src.domain.chat_bot.use_case.i_chatbot_x import IChatBot


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

    def _get_chain(self) -> RunnableSerializable | RunnableSerializable[Any, str]:
        # Init Pinecone db
        llm = ChatOpenAI(model_name="gpt-3.5-turbo", temperature=0)
        self.repo.init()
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

    def query_question(self, query: Question) -> Answer:
        chain = self._get_chain()
        response = chain.invoke(query.text)
        return Answer(text=response)
