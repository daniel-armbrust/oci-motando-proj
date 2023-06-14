#
# queue-classifiedad/app/app.py
#

import sys
import os
from time import sleep

from modules.queue import Queue
from modules.workflow import Workflow

# Globals
MAIN_LOOP_SLEEP_SECS = 120
OCI_API_SLEEP_SECS = 1
APP_ENV = os.environ.get('APP_ENV')
OCI_QUEUE_ID = os.environ.get('OCI_QUEUE_ID')
OCI_REGION_ID = os.environ.get('OCI_REGION_ID')
OCI_OS_NAMESPACE = os.environ.get('OCI_OBJSTR_NAMESPACE')
OCI_BUCKET_SRC = os.environ.get('OCI_BUCKET_MOTANDO_IMGTMP')
OCI_BUCKET_DST = os.environ.get('OCI_BUCKET_MOTANDO_IMG')
OCI_MYSQL_HOSTNAME = os.environ.get('OCI_MYSQL_HOSTNAME')
OCI_MYSQL_USERNAME = os.environ.get('OCI_MYSQL_USERNAME')
OCI_MYSQL_PASSWORD = os.environ.get('OCI_MYSQL_PASSWORD')
OCI_MYSQL_DBNAME = os.environ.get('OCI_MYSQL_DBNAME')


def new_classifiedad(json_msg: str):
    """Processa novo anúncio.
    
    """
    global OCI_REGION_ID, OCI_BUCKET_SRC, OCI_BUCKET_DST, OCI_OS_NAMESPACE, OCI_API_SLEEP_SECS, \
        OCI_QUEUE_ID, APP_ENV

    workflow = Workflow()

    workflow.env = APP_ENV
    workflow.region_id = OCI_REGION_ID
    workflow.bucket_ns = OCI_OS_NAMESPACE
    workflow.bucket_src = OCI_BUCKET_SRC
    workflow.bucket_dst = OCI_BUCKET_DST
    workflow.queue_id = OCI_QUEUE_ID
    workflow.api_sleep = OCI_API_SLEEP_SECS
    
    workflow.new_task(json_msg)


def move_classifiedad(json_msg: str):
    """Movimentação das imagens do bucket temporário para bucket permanente.
    
    """
    global OCI_REGION_ID, OCI_OS_NAMESPACE, OCI_BUCKET_SRC, OCI_QUEUE_ID, OCI_API_SLEEP_SECS, \
        APP_ENV

    workflow = Workflow()

    workflow.env = APP_ENV
    workflow.region_id = OCI_REGION_ID
    workflow.bucket_ns = OCI_OS_NAMESPACE
    workflow.bucket_src = OCI_BUCKET_SRC
    workflow.queue_id = OCI_QUEUE_ID
    workflow.api_sleep = OCI_API_SLEEP_SECS

    workflow.move_task(json_msg)


def publish_classifiedad(json_msg: str):
    """Publicação final do anúncio.

    """
    global OCI_REGION_ID, OCI_OS_NAMESPACE, OCI_BUCKET_DST, OCI_QUEUE_ID, OCI_API_SLEEP_SECS, \
        OCI_MYSQL_HOSTNAME, OCI_MYSQL_USERNAME, OCI_MYSQL_PASSWORD, OCI_MYSQL_DBNAME, APP_ENV

    workflow = Workflow()

    workflow.env = APP_ENV
    workflow.region_id = OCI_REGION_ID
    workflow.bucket_ns = OCI_OS_NAMESPACE
    workflow.bucket_dst = OCI_BUCKET_DST
    workflow.queue_id = OCI_QUEUE_ID
    workflow.api_sleep = OCI_API_SLEEP_SECS
    workflow.db_host = OCI_MYSQL_HOSTNAME
    workflow.db_user = OCI_MYSQL_USERNAME
    workflow.db_passwd = OCI_MYSQL_PASSWORD
    workflow.db_name = OCI_MYSQL_DBNAME

    workflow.publish_task(json_msg)


def process_messages():
    """Inicia o processamento da mensagem.

    """
    global OCI_REGION_ID, OCI_QUEUE_ID, APP_ENV
    
    queue = Queue(queue_id=OCI_QUEUE_ID, region_id=OCI_REGION_ID, env=APP_ENV)

    # Obtém todas as mensagens publicadas 
    json_msg_list = queue.get_all_messages()

    for json_msg in json_msg_list:
        msg_status = json_msg.get('classifiedad_status')

        if msg_status == 'NEW':
            new_classifiedad(json_msg)
        elif msg_status == 'MOVE': 
            move_classifiedad(json_msg)       
        elif msg_status == 'PUBLISH':
            publish_classifiedad(json_msg)
        elif msg_status == 'UPDATE':
            pass
        elif msg_status == 'DELETE':
            pass
        elif msg_status == 'INACTIVE':
            pass
        else:
            pass    


def main():
    global MAIN_LOOP_SLEEP_SECS 

    while True:
        process_messages()
        sleep(MAIN_LOOP_SLEEP_SECS)
    
    sys.exit(0)

    
if __name__ == '__main__':
    main()
else:
    sys.exit(1)