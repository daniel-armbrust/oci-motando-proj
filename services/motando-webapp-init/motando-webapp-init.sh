#!/bin/bash

git clone https://github.com/daniel-armbrust/oci-motando-proj.git

cd ./oci-motando-proj/webapp/

python -m pip install --no-cache-dir -r ./requirements.txt

mysql -u$MYSQL_USER -p$MYSQL_PASSWD -h$MYSQL_HOST -e "CREATE DATABASE $MYSQL_DBNAME CHARSET 'utf8'"

mysql -u$MYSQL_USER -p$MYSQL_PASSWD -h$MYSQL_HOST -e "CREATE DATABASE $RESULTDB_DBNAME CHARSET 'utf8'"

./motando/manage.py migrate

mysql -u$MYSQL_USER -p$MYSQL_PASSWD -h$MYSQL_HOST $MYSQL_DBNAME < ./data/data.sql

./motando/manage.py collectstatic --no-input --verbosity 2 

cd ./data/ ; ../motando/manage.py shell < load2db.py

exit 0
