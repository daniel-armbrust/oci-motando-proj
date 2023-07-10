#
# chat/app/moodules/models.py
#

from pydantic import BaseModel, EmailStr, Field

# All JSON responses follow the JSend specification:
# https://github.com/omniti-labs/jsend

class MessageIn(BaseModel):   
    fullname_from: str = Field(default=None, max_length=200)
    email_from: EmailStr
    telephone_from: str = Field(default=None, max_length=20)   
    classifiedad_id: int
    message: str = Field(default=None, max_length=500)


class MessageOut(BaseModel):
    status: str
    message: str