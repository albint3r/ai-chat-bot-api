from pydantic import BaseModel
from abc import ABC


class IInputSchema(BaseModel, ABC):
    """This is an abstract class for the input schemas"""


class IOutPutSchema(BaseModel, ABC):
    """This is an abstract class for the Output schemas"""
