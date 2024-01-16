from fastapi import FastAPI
from src.routes.chat_bot import chatbot
from src.routes.data_manager import data_manager
from src.routes.auth import auth

app = FastAPI()

app.include_router(auth.router)
app.include_router(chatbot.route)
app.include_router(data_manager.route)
