#!/bin/bash

set -x

cd /opt/webapp/motando/

if [ "$APP_ENV" == "PRD" ]; then
   # MySQL - Web Application Password (read the secret value from OCI VAULT)
    export MYSQL_PASSWD="$(oci --auth resource_principal secrets secret-bundle get \
                               --secret-id "$MYSQL_WEBAPPL_SECRET_OCID" \
                               --stage "LATEST" --query 'data."secret-bundle-content".content' \
                               --raw-output | base64 -d)"

    # OCI - Object Storage Namespace
    export OCI_OBJSTR_NAMESPACE="$(oci --auth resource_principal os ns get \
                                       --query 'data' --raw-output)"
   
   # Motando - OCI Object Storage ACCESS KEY (read the secret value from OCI VAULT)
   export OCI_ACCESS_KEY="$(oci --auth resource_principal secrets secret-bundle get \
                                --secret-id "$MOTANDO_ACCESS_KEY_SECRET_OCID" \
                                --stage "LATEST" --query 'data."secret-bundle-content".content' \
                                --raw-output | base64 -d)"

   # Motando - OCI Object Storage SECRET KEY (read the secret value from OCI VAULT)
   export OCI_SECRET_KEY="$(oci --auth resource_principal secrets secret-bundle get \
                                --secret-id "$MOTANDO_SECRET_KEY_SECRET_OCID" \
                                --stage "LATEST" --query 'data."secret-bundle-content".content' \
                                --raw-output | base64 -d)"
   
   # Motando - OCI Object Storage SECRET KEY (read the secret value from OCI VAULT)
   export DJANGO_SECRET_KEY="$(oci --auth resource_principal secrets secret-bundle get \
                                   --secret-id "$DJANGO_SECRET_KEY_SECRET_OCID" \
                                   --stage "LATEST" --query 'data."secret-bundle-content".content' \
                                   --raw-output | base64 -d)"   

    exec gunicorn motando.wsgi:application --access-logfile - --error-logfile - --bind 0.0.0.0:8000 --workers 2 --threads 2

else
   # Dev environment 
   ./motando-webapp-init.sh
   
   exec ./manage.py runserver 0.0.0.0:8000
   
fi