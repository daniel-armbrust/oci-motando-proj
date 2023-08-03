#!/bin/bash

#
# https://docs.docker.com/config/containers/multi-service_container/
#

# Celery Workers
celery -A tasks worker -l info &

# XMLRPC Server
python xmlrpcs.py &

# Celery FLOWER Monitoring
celery -A tasks flower &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?