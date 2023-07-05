#
# chat/app/app.py
#

import sys
import os
import logging as log

from fastapi import FastAPI, Response
from fastapi.middleware.cors import CORSMiddleware

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


@app.post('/api/chats/messages/classifiedad', response_model=MessageOut, status_code=200)
async def public_message(message: MessageIn, resp: Response) -> MessageOut:
    """Function for send a specified message to the end user. It is public
    because this endpoint is protected by an API Gateway with some RATE LIMIT
    rules.    
    """
    chat = Chat()
    status = chat.send_pubmsg(message)

    if status:
        return {'status': 'success', 'message': 'The message was successful send.'}
    else:
        resp.status_code = 422        
        return {'status' : 'error', 'message' : 'Unable to process new Chat message.'}
       