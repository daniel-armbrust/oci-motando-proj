#!/bin/bash

set -x

#------------------#
# Motando Database #
#------------------# 

# MySQL - Admin Password (read the secret value from OCI VAULT)
export MYSQL_ADMIN_PASSWD="$(oci --auth resource_principal secrets secret-bundle get \
                                 --secret-id "$MYSQL_ADMIN_SECRET_OCID" \
                                 --stage "LATEST" --query 'data."secret-bundle-content".content' \
                                 --raw-output | base64 -d)"

# MySQL - Web Application Password (read the secret value from OCI VAULT)
export MYSQL_WEBAPPL_PASSWD="$(oci --auth resource_principal secrets secret-bundle get \
                                   --secret-id "$MYSQL_WEBAPPL_SECRET_OCID" \
                                   --stage "LATEST" --query 'data."secret-bundle-content".content' \
                                   --raw-output | base64 -d)"

if [ \( -z "$MYSQL_ADMIN_PASSWD" \) -o \( -z "$MYSQL_WEBAPPL_PASSWD" \) ]; then
   exit 1
fi

# CHARSET UTF8MB4 = UTF8

mysql -u admin -p$MYSQL_ADMIN_PASSWD -h $MYSQL_HOST \
    -e "CREATE DATABASE $MYSQL_WEBAPPL_DBNAME CHARSET UTF8MB4"

mysql -u admin -p$MYSQL_ADMIN_PASSWD -h $MYSQL_HOST \
    -e "CREATE USER '$MYSQL_WEBAPPL_USER' IDENTIFIED BY '$MYSQL_WEBAPPL_PASSWD'"

mysql -u admin -p$MYSQL_ADMIN_PASSWD -h $MYSQL_HOST \
    -e "GRANT ALL PRIVILEGES ON $MYSQL_WEBAPPL_DBNAME.* TO '$MYSQL_WEBAPPL_USER'"


#---------------------------#
# Motando GitHub Repo Clone #
#---------------------------# 

git clone "$GITHUB_REPO_URL"


#-------------------------------#
# Python - Install Dependencies #
#-------------------------------#

cd ./oci-motando-proj/webapp/

python -m pip install --no-cache-dir -r ./requirements.txt


#---------------------------------#
# Django Web Framework            #
# https://www.djangoproject.com/  #
#---------------------------------#

# Needs for Resource Principal authentication inside OCI
export APP_ENV='PRD'

# OCI - Primary region (ex: sa-saopaulo-1)
export REGION_ID

# OCI - Web Application Logging OCID
export WEBAPP_OCI_LOG_ID

# OCI - Object Storage Namespace
export OCI_OBJSTR_NAMESPACE="$(oci --auth resource_principal os ns get --query 'data' --raw-output)"


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

if [ \( -z "$OCI_ACCESS_KEY" \) -o \( -z "$OCI_SECRET_KEY" \) ]; then
   exit 1
fi

# Database environment variables used by Django Web Framework 
export MYSQL_DBNAME="$MYSQL_WEBAPPL_DBNAME"
export MYSQL_USER="$MYSQL_WEBAPPL_USER"
export MYSQL_PASSWD="$MYSQL_WEBAPPL_PASSWD"
export MYSQL_HOST


# Django Web Framework - Migrations
# https://docs.djangoproject.com/en/4.2/topics/migrations/
./motando/manage.py migrate

# Motando - Loads some application specific data into database
mysql -u $MYSQL_WEBAPPL_USER -p$MYSQL_WEBAPPL_PASSWD -h $MYSQL_HOST \
    $MYSQL_WEBAPPL_DBNAME < ./data/data.sql

# Django Web Framework - static files (loads static files into Object Storage)
# https://docs.djangoproject.com/en/4.2/howto/static-files/
./motando/manage.py collectstatic --no-input --verbosity 2 


# Done...
exit 0