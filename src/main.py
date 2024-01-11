from fastapi import FastAPI
from src.routes.chat_bot import chatbot

app = FastAPI()

app.include_router(chatbot.route)
