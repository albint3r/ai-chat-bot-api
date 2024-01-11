FROM python:3.10
WORKDIR /tobe_cv
COPY ./requirements.txt /tobe_cv/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
COPY . /tobe_cv
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]