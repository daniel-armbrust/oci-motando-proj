#!/bin/bash

#------------------#
# Motando Database #
#------------------# 

# CHARSET UTF8MB4 = UTF8

mysql -u admin -p$MYSQL_ADMIN_PASSWD -h $MYSQL_HOST \
    -e "CREATE DATABASE $MYSQL_WEBAPPL_DBNAME CHARSET UTF8MB4"

mysql -u admin -p$MYSQL_ADMIN_PASSWD -h $MYSQL_HOST \
    -e "CREATE USER '$MYSQL_WEBAPPL_USER' IDENTIFIED BY ''"

mysql -u admin -p$MYSQL_ADMIN_PASSWD -h $MYSQL_HOST \
    -e "GRANT ALL PRIVILEGES ON $MYSQL_WEBAPPL_DBNAME.* TO '$MYSQL_WEBAPPL_USER'"

mysql -u admin -p$MYSQL_ADMIN_PASSWD -h $MYSQL_HOST \
    -e "FLUSH PRIVILEGES"


#git clone https://github.com/daniel-armbrust/oci-motando-proj.git

#cd ./oci-motando-proj/webapp/

#python -m pip install --no-cache-dir -r ./requirements.txt

#./motando/manage.py migrate

#mysql -u$MYSQL_USER -p$MYSQL_PASSWD -h$MYSQL_HOST $MYSQL_DBNAME < ./data/data.sql

#./motando/manage.py collectstatic --no-input --verbosity 2 

#cd ./data/ ; ../motando/manage.py shell < load2db.py

exit 0
