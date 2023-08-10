#
# celery-classifiedad/app/tasks.py
#

import os
import sys
import logging as log
from time import sleep

from celery import Celery
from celery.signals import after_setup_logger

from modules.ocilog import OciLogHandler
from modules.classifiedad import Classifiedad

# Globals
OCI_API_SLEEP_SECS = 2
TASK_SLEEP_SECS = 60
MAX_LOOP_COUNT = 30
APP_ENV = os.environ.get('APP_ENV')
OCI_LOG_ID = os.environ.get('OCI_LOG_ID')
RESULTDB_HOST = os.environ.get('RESULTDB_HOST')
RESULTDB_USER = os.environ.get('RESULTDB_USER')
RESULTDB_PASSWD = os.environ.get('RESULTDB_PASSWD')
RESULTDB_DBNAME = os.environ.get('RESULTDB_DBNAME')
APPDB_HOST = os.environ.get('APPDB_HOST')
APPDB_USER = os.environ.get('APPDB_USER')
APPDB_PASSWD = os.environ.get('APPDB_PASSWD')
APPDB_DBNAME = os.environ.get('APPDB_DBNAME')
BROKER_HOST = os.environ.get('BROKER_HOST')
BROKER_USER = os.environ.get('BROKER_USER')
BROKER_PASSWD = os.environ.get('BROKER_PASSWD')
BROKER_VHOST = os.environ.get('BROKER_VHOST')
OCI_REGION_ID = os.environ.get('OCI_REGION_ID')
OCI_OS_NAMESPACE = os.environ.get('OCI_OBJSTR_NAMESPACE')
OCI_BUCKET_IMGTMP = os.environ.get('OCI_BUCKET_MOTANDO_IMGTMP')
OCI_BUCKET_IMG = os.environ.get('OCI_BUCKET_MOTANDO_IMG')

# Logs to STDOUT and to OCI LOGGING Service.
stdout_handler = log.StreamHandler(stream=sys.stdout)
stdout_handler.setLevel(log.INFO)
ocilog_handler = OciLogHandler(log_id=OCI_LOG_ID, env=APP_ENV)

log.basicConfig(
    level=log.INFO,
    format='%(asctime)s:%(levelname)s:%(module)s(%(lineno)d):%(message)s',
    handlers=[stdout_handler, ocilog_handler]
)

# Celery init
app = Celery('tasks', 
             broker=f'amqp://{BROKER_USER}:{BROKER_PASSWD}@{BROKER_HOST}:5672/{BROKER_VHOST}', 
             backend=f'db+mysql+mysqlconnector://{RESULTDB_USER}:{RESULTDB_PASSWD}@{RESULTDB_HOST}:3306/{RESULTDB_DBNAME}')


@after_setup_logger.connect
def setup_loggers(logger, *args, **kwargs):    
    logger = log.getLogger('celery')
    logger.addHandler(ocilog_handler)


@app.task
def new_classifiedad(classifiedad_id: int):
    """Task for publish new classifiedad.
    
    """
    global APP_ENV, OCI_REGION_ID, OCI_OS_NAMESPACE, OCI_BUCKET_IMGTMP, \
        OCI_BUCKET_IMG, OCI_API_SLEEP_SECS, TASK_SLEEP_SECS, APPDB_HOST, \
        APPDB_USER, APPDB_DBNAME, MAX_LOOP_COUNT

    classifiedad = Classifiedad(classifiedad_id=classifiedad_id,
                                env=APP_ENV,
                                region_id=OCI_REGION_ID,
                                bucket_ns=OCI_OS_NAMESPACE,
                                bucket_tmp=OCI_BUCKET_IMGTMP,
                                bucket_img=OCI_BUCKET_IMG,
                                api_sleep=OCI_API_SLEEP_SECS,
                                db_host=APPDB_HOST,
                                db_user=APPDB_USER,
                                db_passwd=APPDB_PASSWD,
                                db_name=APPDB_DBNAME)
        
    classifiedad.new()

    i = 0
    while i < MAX_LOOP_COUNT:
        if classifiedad.done():
            published = classifiedad.publish()

            if not published:
                pass            
            break
        
        sleep(TASK_SLEEP_SECS)
        i += 1
    

@app.task
def update_classifiedad(classifiedad_id: int, old_img_list: list):
    """Task for update the classifiedad.
    
    """
    global APP_ENV, OCI_REGION_ID, OCI_OS_NAMESPACE, OCI_BUCKET_IMGTMP, \
        OCI_BUCKET_IMG, OCI_API_SLEEP_SECS, TASK_SLEEP_SECS, APPDB_HOST, \
        APPDB_USER, APPDB_DBNAME, MAX_LOOP_COUNT   
   
    classifiedad = Classifiedad(classifiedad_id=classifiedad_id,
                                env=APP_ENV,
                                region_id=OCI_REGION_ID,
                                bucket_ns=OCI_OS_NAMESPACE,
                                bucket_tmp=OCI_BUCKET_IMGTMP,
                                bucket_img=OCI_BUCKET_IMG,
                                api_sleep=OCI_API_SLEEP_SECS,
                                db_host=APPDB_HOST,
                                db_user=APPDB_USER,
                                db_passwd=APPDB_PASSWD,
                                db_name=APPDB_DBNAME)
    
    classifiedad.update(old_img_list)

    i = 0
    while i < MAX_LOOP_COUNT:
        if classifiedad.done():
            published = classifiedad.publish()

            if not published:
                pass            
            break
        
        sleep(TASK_SLEEP_SECS)
        i += 1