FROM python:3.10
WORKDIR /chat_ai
COPY ./requirements.txt /chat_ai/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
COPY . /chat_ai
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]