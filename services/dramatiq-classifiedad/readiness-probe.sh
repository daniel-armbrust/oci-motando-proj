#!/bin/bash

dramatiq_count=$(ps -ef|grep 'dramatiq'|grep -v grep|wc -l)

if [ $dramatiq_count -lt 1 ]; then
   exit 1
fi

xmlrpcs_count=$(ps -ef|grep 'xmlrpcs.py'|grep -v grep|wc -l)

if [ $xmlrpcs_count -ne 1 ]; then
   exit 1
fi

exit 0