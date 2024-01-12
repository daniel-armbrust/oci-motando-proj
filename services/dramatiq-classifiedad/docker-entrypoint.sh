#!/bin/bash

if [ "$APP_ENV" == 'PRD' ]; then
    # MySQL - Web Application Password (read the secret value from OCI VAULT)
    export MYSQL_PASSWD="$(oci --auth resource_principal secrets secret-bundle get \
                               --secret-id "$MYSQL_WEBAPPL_SECRET_OCID" \
                               --stage "LATEST" --query 'data."secret-bundle-content".content' \
                               --raw-output | base64 -d)"

    # OCI - Object Storage Namespace
    export OCI_OBJSTR_NAMESPACE="$(oci --auth resource_principal os ns get \
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
