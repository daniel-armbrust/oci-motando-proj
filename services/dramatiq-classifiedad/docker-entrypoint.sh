#!/bin/bash

# Debug
#set -x

if [ "$APP_ENV" == 'PRD' ]; then
    OCI_AUTH_TYPE=''

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
fi

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
