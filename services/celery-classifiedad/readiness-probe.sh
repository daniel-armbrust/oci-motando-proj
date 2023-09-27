#!/bin/bash

/usr/local/bin/celery -A tasks status

if [ $? -ne 0 ]; then
   exit $?
fi

xmlrpcs_count=$(ps -ef|grep 'xmlrpcs.py'|grep -v grep|wc -l)

if [ $xmlrpcs_count -ne 1 ]; then
   exit 1
fi

exit 0