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
from modules.models import MessageIn, MessageOut
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


@app.get('/api/chats/messages', response_model=None, status_code=200)
async def read_message(email_to: Optional[str] = None, email_from: Optional[str] = None, resp: Response = None):
    """ """
    chat =  Chat()

    if email_to:
        messages = chat.read_messages(email_to=email_to)
    elif email_from:
        messages = chat.read_messages(email_from=email_from)
    else:
        resp.status_code = 400
        return {'status' : 'fail', 'message' : 'Unable to read Chat messages.'}

    if messages:        
        print('ooooooooooo')
    else:
         resp.status_code = 404
         return {'status' : 'fail', 'message' : 'No message found.'}


@app.post('/api/chats/messages', response_model=MessageOut, status_code=200)
async def new_message(message: MessageIn, resp: Response) -> MessageOut:
    """Function for send a specified message to some user. 

    """
    chat = Chat()
    status = chat.new_message(message)

    if status:
        return {'status': 'success', 'message': 'The message was successful send.'}
    else:
        resp.status_code = 422   
        return {'status' : 'fail', 'message' : 'Unable to process new Chat message.'}


