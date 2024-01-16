from enum import Enum


class Template(Enum):
    CONDENSE_QUESTION_PROMPT = """Given the following conversation and a follow up question, rephrase the follow up question to be a standalone question, in its original language.
        Chat History:
        {chat_history}
        Follow Up Input: {question}
        Standalone question:"""
    ANSWER_PROMPT = """Use the following pieces of context to answer the question at the end.
        If you don't know the answer, just say that you don't know, don't try to make up an answer.
        Use three sentences maximum and keep the answer as concise as possible.
        Always say "thanks for asking!" at the end of the answer.
    
        {context}
    
        Question: {question}
    
        Helpful Answer:"""
    DEFAULT_DOCUMENT_PROMPT = "{page_content}"
