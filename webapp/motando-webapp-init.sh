#!/bin/bash

# FIXME: Wait for MySQL to become UP.
sleep 15s

export MYSQL_USER='root'

MOTANDO_DB=$(mysql -u$MYSQL_USER -p$MYSQL_PASSWD -h$MYSQL_HOST -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '$MYSQL_DBNAME'")

if [ ! -z "$MOTANDO_DB" ]; then
   exit 0
fi

cd /opt/webapp/motando/

# CHARSET UTF8MB4 = UTF8
mysql -u$MYSQL_USER -p$MYSQL_PASSWD -h $MYSQL_HOST \
    -e "CREATE DATABASE $MYSQL_DBNAME CHARSET UTF8MB4"

mysql -u$MYSQL_USER -p$MYSQL_PASSWD -h $MYSQL_HOST \
    -e "CREATE USER 'motandousr' IDENTIFIED BY 'secreto'"

mysql -u$MYSQL_USER -p$MYSQL_PASSWD -h $MYSQL_HOST \
    -e "GRANT ALL PRIVILEGES ON motandodb.* TO 'motandousr'"

./manage.py migrate

exit 0