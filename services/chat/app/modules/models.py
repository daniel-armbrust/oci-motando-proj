#
# chat/app/moodules/models.py
#

from pydantic import BaseModel, EmailStr, Field
from typing import List, Union

# All JSON responses follow the JSend specification:
# https://github.com/omniti-labs/jsend

class NewMessageIn(BaseModel):   
    user_from_fullname: str = Field(default=None, max_length=200)
    user_from_email: EmailStr
    user_from_telephone: str = Field(default=None, max_length=20)   
    classifiedad_id: int
    message: str = Field(default=None, max_length=500)


class NewMessageOut(BaseModel):
    status: str
    message: str


class MessagesOut(BaseModel):
    status: str      
    data: List[dict]  