#!/bin/bash

if [ "$APP_ENV" == "DEV" ]; then
   cd /opt/webapp/motando/
   exec ./manage.py runserver 0.0.0.0:8000
else
   exit
fi