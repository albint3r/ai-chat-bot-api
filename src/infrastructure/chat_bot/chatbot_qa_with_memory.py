from operator import itemgetter
from typing import Any

from langchain.memory import ConversationBufferMemory
from langchain_core.documents import Document
from langchain_core.embeddings import Embeddings
from langchain_core.messages import get_buffer_string
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate, PromptTemplate, format_document
from langchain_core.runnables import RunnableParallel, RunnablePassthrough, RunnableLambda, RunnableSerializable
from langchain_core.tracers import ConsoleCallbackHandler
from langchain_openai import ChatOpenAI

from src.domain.chat_bot.entities.answer import Answer
from src.domain.chat_bot.entities.question import Question
from src.domain.chat_bot.enums.template import Template
from src.domain.chat_bot.repositories.i_vectors_repository import IVectorRepository
from src.domain.chat_bot.use_case.i_chatbot_x import IChatBot


class ChatBotQAWithMemory(IChatBot):
    repo: IVectorRepository
    embeddings_model: Embeddings | None = None
    index_name: str
    memory: ConversationBufferMemory | None = None

    def generate_chain(self) -> RunnableSerializable | RunnableSerializable[Any, str]:
        llm = ChatOpenAI(temperature=0)
        self.repo.init()
        vectorstore = self.repo.get_vectorstore(self.index_name, self.embeddings_model, "text")
        retriever = vectorstore.as_retriever()
        CONDENSE_QUESTION_PROMPT = PromptTemplate.from_template(Template.CONDENSE_QUESTION_PROMPT.value)
        ANSWER_PROMPT = ChatPromptTemplate.from_template(Template.ANSWER_PROMPT.value)
        DEFAULT_DOCUMENT_PROMPT = PromptTemplate.from_template(template=Template.DEFAULT_DOCUMENT_PROMPT.value)

        def _combine_documents(
                docs: list[Document], document_prompt=DEFAULT_DOCUMENT_PROMPT, document_separator="\n\n"
        ):
            doc_strings = [format_document(doc, document_prompt) for doc in docs]
            return document_separator.join(doc_strings)

        # Star Creating chain
        loaded_memory = RunnablePassthrough.assign(
            chat_history=RunnableLambda(self.memory.load_memory_variables) | itemgetter("history"),
        )

        standalone_question = RunnableParallel(
            standalone_question={
                # create their own string in the value [standalone_question] this value would be inserted later.
                "standalone_question": {
                                           "question": lambda x: x["question"],
                                           "chat_history": lambda x: get_buffer_string(x["chat_history"]),
                                       }
                                       | CONDENSE_QUESTION_PROMPT
                                       | llm
                                       | StrOutputParser(),
            }
        )

        retrieved_documents = {
            "docs": itemgetter("standalone_question") | RunnableLambda(lambda x: x['standalone_question']) | retriever,
            "question": lambda x: x["standalone_question"],
        }

        final_inputs = {
            "context": lambda x: _combine_documents(x["docs"]),
            "question": itemgetter("question"),
        }

        answer = {
            "answer": final_inputs | ANSWER_PROMPT | llm | StrOutputParser(),
            "docs": itemgetter("docs"),
        }

        return loaded_memory | standalone_question | retrieved_documents | answer

    def query_question(self, query: Question, inputs: dict[str, str]) -> Answer:
        chain = self.generate_chain()
        response = chain.invoke(inputs, config={'callbacks': [ConsoleCallbackHandler()]})
        self.memory.save_context(inputs, {"answer": response["answer"]})
        self.memory.load_memory_variables({})
        return Answer(text=response['answer'])
