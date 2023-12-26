#!/bin/bash

#
# https://docs.docker.com/config/containers/multi-service_container/
#

# Dramatiq Workers
dramatiq tasks &

# XMLRPC Server
python xmlrpcs.py &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?
