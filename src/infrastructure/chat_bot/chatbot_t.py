from typing import Any

from langchain_core.documents import Document
from langchain_core.embeddings import Embeddings
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import RunnablePassthrough, RunnableSerializable, RunnableParallel
from langchain_core.tracers import ConsoleCallbackHandler
from langchain_openai import ChatOpenAI

from src.domain.chat_bot.entities.answer import Answer
from src.domain.chat_bot.entities.question import Question
from src.domain.chat_bot.repositories.i_vectors_repository import IVectorRepository
from src.domain.chat_bot.use_case.i_chatbot_x import IChatBot


class ChatBotT(IChatBot):
    repo: IVectorRepository
    embeddings_model: Embeddings | None = None
    index_name: str
    template: str = """You are an assistant for question-answering tasks. Use the following pieces of retrieved context to answer the question.
     If you don't know the answer, just say that you don't know. Use three sentences maximum and keep the answer concise.
     Only respond in the language in which the question was asked.
     Question: {question}
     <context>
     Context: {context}
     </context>
     Answer:"""

    class Config:
        arbitrary_types_allowed = True

    def _format_docs(self, documents: list[Document]) -> str:
        return "\n\n".join(doc.page_content for doc in documents)

    def generate_chain(self) -> RunnableSerializable | RunnableSerializable[Any, str]:
        # Init Pinecone db
        llm = ChatOpenAI(model_name="gpt-3.5-turbo", temperature=0)
        self.repo.init()
        vectorstore = self.repo.get_vectorstore(self.index_name, self.embeddings_model, "text")
        # Get retrievers
        retriever = vectorstore.as_retriever(search_type="similarity", search_kwargs={"k": 4})
        custom_prompt = ChatPromptTemplate.from_messages([("system", self.template)])
        return (
                RunnableParallel(context=retriever | self._format_docs, question=RunnablePassthrough())
                | custom_prompt
                | llm
                | StrOutputParser()
        )

    def query_question(self, query: Question) -> Answer:
        chain = self.generate_chain()
        response = chain.invoke(query.text,
                                config={'callbacks': [ConsoleCallbackHandler()]})
        return Answer(text=response)
