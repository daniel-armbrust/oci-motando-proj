#
# dramatiq-classifiedad/app/tasks.py
#

import os
import sys
import logging as log
from time import sleep

import dramatiq
from dramatiq.brokers.redis import RedisBroker

from modules.ocilog import OciLogHandler
from modules.classifiedad import Classifiedad

# Globals
TASK_SLEEP_SECS = 60
MAX_LOOP_COUNT = 30
APP_ENV = os.environ.get('APP_ENV')

# Application database to update the classifiedad status.
MYSQL_HOST = os.environ.get('MYSQL_HOST')
MYSQL_USER = os.environ.get('MYSQL_USER')
MYSQL_PASSWD = os.environ.get('MYSQL_PASSWD')
MYSQL_DBNAME = os.environ.get('MYSQL_DBNAME')

# Dramatiq Redis Broker
REDIS_HOST = os.environ.get('REDIS_HOST')
REDIS_PORT = os.environ.get('REDIS_PORT', 6379)
REDIS_PASSWD = os.environ.get('REDIS_PASSWD')

# OCI 
OCI_REGION_ID = os.environ.get('OCI_REGION_ID')
OCI_OS_NAMESPACE = os.environ.get('OCI_OBJSTR_NAMESPACE')
OCI_BUCKET_IMG = os.environ.get('OCI_BUCKET_MOTANDO_IMG')
OCI_BUCKET_IMGTMP = os.environ.get('OCI_BUCKET_MOTANDO_IMGTMP')
OCI_LOG_ID = os.environ.get('WORKFLOW_OCI_LOG_ID')
OCI_API_SLEEP_SECS = 2

# Logs to STDOUT and to OCI LOGGING Service.
stdout_handler = log.StreamHandler(stream=sys.stdout)
stdout_handler.setLevel(log.INFO)
ocilog_handler = OciLogHandler(log_id=OCI_LOG_ID, env=APP_ENV)

log.basicConfig(
    level=log.INFO,
    format='%(asctime)s:%(levelname)s:%(module)s(%(lineno)d):%(message)s',
    handlers=[stdout_handler, ocilog_handler]
)

# Dramatiq init
redis_broker = None

if APP_ENV == 'PRD':
    # OCI Redis uses TLS by default.
    redis_broker = RedisBroker(host=REDIS_HOST, 
                               port=int(REDIS_PORT),                                
                               ssl=True,
                               ssl_cert_reqs=None)
else:
    redis_broker = RedisBroker(host=REDIS_HOST, 
                               port=int(REDIS_PORT), 
                               password=REDIS_PASSWD)

dramatiq.set_broker(redis_broker)


@dramatiq.actor
def new_classifiedad(classifiedad_id: int):
    """Task to publish new classifiedad.

    """
    global APP_ENV, OCI_REGION_ID, OCI_OS_NAMESPACE, OCI_BUCKET_IMGTMP, \
        OCI_BUCKET_IMG, OCI_API_SLEEP_SECS, TASK_SLEEP_SECS, MYSQL_HOST, \
        MYSQL_USER, MYSQL_PASSWD, MYSQL_DBNAME, MAX_LOOP_COUNT

    classifiedad = Classifiedad(classifiedad_id=classifiedad_id,
                                env=APP_ENV,
                                region_id=OCI_REGION_ID,
                                bucket_ns=OCI_OS_NAMESPACE,
                                bucket_tmp=OCI_BUCKET_IMGTMP,
                                bucket_img=OCI_BUCKET_IMG,
                                api_sleep=OCI_API_SLEEP_SECS,
                                db_host=MYSQL_HOST,
                                db_user=MYSQL_USER,
                                db_passwd=MYSQL_PASSWD,
                                db_name=MYSQL_DBNAME)

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


@dramatiq.actor
def update_classifiedad(classifiedad_id: int, old_img_list: list):
    """Task to update the classifiedad.

    """
    global APP_ENV, OCI_REGION_ID, OCI_OS_NAMESPACE, OCI_BUCKET_IMGTMP, \
        OCI_BUCKET_IMG, OCI_API_SLEEP_SECS, TASK_SLEEP_SECS, MYSQL_HOST, \
        MYSQL_USER, MYSQL_PASSWD, MYSQL_DBNAME, MAX_LOOP_COUNT

    classifiedad = Classifiedad(classifiedad_id=classifiedad_id,
                                env=APP_ENV,
                                region_id=OCI_REGION_ID,
                                bucket_ns=OCI_OS_NAMESPACE,
                                bucket_tmp=OCI_BUCKET_IMGTMP,
                                bucket_img=OCI_BUCKET_IMG,
                                api_sleep=OCI_API_SLEEP_SECS,
                                db_host=MYSQL_HOST,
                                db_user=MYSQL_USER,
                                db_passwd=MYSQL_PASSWD,
                                db_name=MYSQL_DBNAME)

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


@dramatiq.actor
def delete_classifiedad(classifiedad_id: int):
    """Task to delete the classifiedad.

    """
    global APP_ENV, OCI_REGION_ID, OCI_OS_NAMESPACE, OCI_BUCKET_IMGTMP, \
        OCI_BUCKET_IMG, OCI_API_SLEEP_SECS, TASK_SLEEP_SECS, MYSQL_HOST, \
        MYSQL_USER, MYSQL_PASSWD, MYSQL_DBNAME, MAX_LOOP_COUNT

    classifiedad = Classifiedad(classifiedad_id=classifiedad_id,
                                env=APP_ENV,
                                region_id=OCI_REGION_ID,
                                bucket_ns=OCI_OS_NAMESPACE,
                                bucket_tmp=OCI_BUCKET_IMGTMP,
                                bucket_img=OCI_BUCKET_IMG,
                                api_sleep=OCI_API_SLEEP_SECS,
                                db_host=MYSQL_HOST,
                                db_user=MYSQL_USER,
                                db_passwd=MYSQL_PASSWD,
                                db_name=MYSQL_DBNAME)

    classifiedad.delete(classifiedad_id)