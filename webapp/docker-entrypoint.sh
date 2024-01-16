#!/bin/bash

set -x

get_values_from_oci() {
   
   declare OCI_AUTH_TYPE=''

   if [ "$DEPLOYMENT_ENV" == 'CI' ]; then
      # OCI - Container Instances   
      OCI_AUTH_TYPE='resource_principal'
   else
      # OCI - OKE
      OCI_AUTH_TYPE='instance_principal'
   fi
   
   # MySQL - Web Application Password (read the secret value from OCI VAULT)
   export MYSQL_PASSWD="$(oci --auth "$OCI_AUTH_TYPE" secrets secret-bundle get \
                              --secret-id "$MYSQL_WEBAPPL_SECRET_OCID" \
                              --stage "LATEST" --query 'data."secret-bundle-content".content' \
                              --raw-output | base64 -d)"

   # OCI - Object Storage Namespace
   export OCI_OBJSTR_NAMESPACE="$(oci --auth "$OCI_AUTH_TYPE" os ns get \
                                      --query 'data' --raw-output)"
   
   # Motando - OCI Object Storage ACCESS KEY (read the secret value from OCI VAULT)
   export OCI_ACCESS_KEY="$(oci --auth "$OCI_AUTH_TYPE" secrets secret-bundle get \
                                --secret-id "$MOTANDO_ACCESS_KEY_SECRET_OCID" \
                                --stage "LATEST" --query 'data."secret-bundle-content".content' \
                                --raw-output | base64 -d)"

   # Motando - OCI Object Storage SECRET KEY (read the secret value from OCI VAULT)
   export OCI_SECRET_KEY="$(oci --auth "$OCI_AUTH_TYPE" secrets secret-bundle get \
                                --secret-id "$MOTANDO_SECRET_KEY_SECRET_OCID" \
                                --stage "LATEST" --query 'data."secret-bundle-content".content' \
                                --raw-output | base64 -d)"
   
   # Motando - OCI Object Storage SECRET KEY (read the secret value from OCI VAULT)
   export DJANGO_SECRET_KEY="$(oci --auth "$OCI_AUTH_TYPE" secrets secret-bundle get \
                                   --secret-id "$DJANGO_SECRET_KEY_SECRET_OCID" \
                                   --stage "LATEST" --query 'data."secret-bundle-content".content' \
                                   --raw-output | base64 -d)"  

   # MySQL - Web Application Password (read the secret value from OCI VAULT)
   export MYSQL_PASSWD="$(oci --auth "$OCI_AUTH_TYPE" secrets secret-bundle get \
                              --secret-id "$MYSQL_WEBAPPL_SECRET_OCID" \
                              --stage "LATEST" --query 'data."secret-bundle-content".content' \
                              --raw-output | base64 -d)"
}

cd /opt/webapp/motando/

if [ "$APP_ENV" == "PRD" ]; then
   get_values_from_oci
   exec gunicorn motando.wsgi:application --access-logfile - --error-logfile - --bind 0.0.0.0:8000 --workers 2 --threads 2
else      
   exec ./manage.py runserver 0.0.0.0:8000   
fi