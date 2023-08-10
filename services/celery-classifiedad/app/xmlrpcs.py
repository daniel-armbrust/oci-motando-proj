#
# celery-classifiedad/app/xmlrpc.py
#

import os
import sys
import logging as log
from xmlrpc.server import SimpleXMLRPCServer

from modules.ocilog import OciLogHandler
import tasks


# Globals
OCI_API_SLEEP_SECS = 2
APP_ENV = os.environ.get('APP_ENV')
APP_PORT = os.environ.get('CLASSIFIEDAD_TASK_QUEUE_PORT', 8100)
OCI_LOG_ID = os.environ.get('OCI_LOG_ID')


def new_classifiedad(classifiedad_id: int):
    tasks.new_classifiedad.delay(classifiedad_id)


def update_classifiedad(classifiedad_id: int, old_img_list: list):   
   tasks.update_classifiedad.delay(classifiedad_id, old_img_list)
        

def main():
    global APP_PORT

    xmlrpc_server = SimpleXMLRPCServer(('0.0.0.0', APP_PORT), allow_none=True)
    xmlrpc_server.register_function(new_classifiedad)
    xmlrpc_server.register_function(update_classifiedad)
    xmlrpc_server.serve_forever()


if __name__ == '__main__':
    # Logs to STDOUT and to OCI LOGGING Service.
    stdout_handler = log.StreamHandler(stream=sys.stdout)
    stdout_handler.setLevel(log.INFO)
    ocilog_handler = OciLogHandler(log_id=OCI_LOG_ID, env=APP_ENV)

    log.basicConfig(
        level=log.INFO,
        format='%(asctime)s:%(levelname)s:%(module)s(%(lineno)d):%(message)s',
        handlers=[stdout_handler, ocilog_handler]
    )

    main()