from fastapi import APIRouter
from langchain_openai import OpenAIEmbeddings

from credentials_provider import credentials_provider
from src.domain.chat_bot.entities.answer import Answer
from src.domain.chat_bot.entities.question import Question
from src.infrastructure.chat_bot.chatbot import ChatBotX
from src.infrastructure.chat_bot.pinecone_repository import PineconeRepository

route = APIRouter(prefix='/chatbot',
                  tags=['chatbot'], )


@route.post('/v1/qa-chatbot')
def qa_chatbot(question: Question) -> Answer:
    chatbot = ChatBotX(index_name='tobecv', repo=PineconeRepository(),
                       embeddings_model=OpenAIEmbeddings(openai_api_key=credentials_provider.open_ai_api_key))
    answer = chatbot.query_question(question)
    return answer
