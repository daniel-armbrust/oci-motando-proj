#
# chat/app/app.py
#

import sys
import os
import logging as log

from fastapi import FastAPI, Response
from fastapi.middleware.cors import CORSMiddleware
from typing import Optional

from modules.ocilog import OciLogHandler
from modules.models import NewMessageIn, NewMessageOut, MessagesOut
from modules.chat import Chat

# Globals
APP_ENV = os.getenv('APP_ENV')
CHAT_LOG_ID = os.environ.get('CHAT_LOG_ID')

# Logs are sent to STDOUT first and then to OCI LOGGING services
stdout_handler = log.StreamHandler(stream=sys.stdout)
stdout_handler.setLevel(log.INFO)
ocilog_handler = OciLogHandler(log_id=CHAT_LOG_ID, env=APP_ENV)

log.basicConfig(
    level=log.INFO,
    format='%(asctime)s:%(levelname)s:%(module)s(%(lineno)d):%(message)s',
    handlers=[stdout_handler, ocilog_handler]
)

# FastAPI initialization.
app = FastAPI()
app.add_middleware(CORSMiddleware, allow_origins=['*'], allow_methods=['GET', 'POST'])


@app.get('/api/chats/messages/user/to/{user_to_id}', status_code=200)
async def read_messages_to(user_to_id: int, resp: Response):
    """Read messages intended for YOU (selling a motorcycle).

    """
    chat = Chat()

    messages = chat.read_messages(user_to_id=user_to_id)

    if messages:            
        messages_list = []

        for data in messages:             
            messages_list.append(data.get('messages')[0])
                
        messages_resp = MessagesOut(
            status = 'success', 
            classifiedad_id = data.get('classifiedad_id'),
            user_from_fullname = data.get('user_from_fullname'),
            user_from_email = data.get('user_from_email'),
            user_from_telephone = data.get('user_from_telephone'),
            data = messages_list
        )

        return messages_resp
                 
    else:
         resp.status_code = 404
         return {'status' : 'fail', 'message' : 'No message found.'}


@app.get('/api/chats/messages/user/from/{user_from_id}', status_code=200)
async def read_messages_from(user_from_id: int, resp: Response):
    """Read messages sent by you (buying a motorcycle).
    
    """
    chat = Chat()

    messages = chat.read_messages(user_from_id=user_from_id)

    if messages:        
        messages_list = []

        for data in messages:             
            messages_list.append(data.get('messages')[0])
                
        messages_resp = MessagesOut(
            status = 'success', 
            classifiedad_id = data.get('classifiedad_id'),
            user_from_fullname = data.get('user_from_fullname'),
            user_from_email = data.get('user_from_email'),
            user_from_telephone = data.get('user_from_telephone'),
            data = messages_list
        )

        return messages_resp
                 
    else:
         resp.status_code = 404
         return {'status' : 'fail', 'message' : 'No message found.'}


@app.post('/api/chats/messages', response_model=NewMessageOut, status_code=200)
async def new_message(message: NewMessageIn, resp: Response) -> NewMessageOut:
    """Function for send a specified message to some user. 

    """
    chat = Chat()
    status = chat.new_message(message)

    if status:
        return {'status': 'success', 'message': 'The message was successful send.'}
    else:
        resp.status_code = 422   
        return {'status' : 'fail', 'message' : 'Unable to process new Chat message.'}


