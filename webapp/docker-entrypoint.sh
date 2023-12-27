#!/bin/bash

cd /opt/webapp/motando/

if [ "$APP_ENV" == "DEV" ]; then
   ./motando-webapp-init.sh
   exec ./manage.py runserver 0.0.0.0:8000
else   
   exec gunicorn motando.wsgi:application --access-logfile - --error-logfile - --bind 0.0.0.0:8000 --workers 2 --threads 2
fi