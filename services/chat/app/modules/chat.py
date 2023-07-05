#
# chat/app/modules/chat.py
#

import os
from datetime import datetime
import logging as log

from .models import MessageIn
from .nosql import NoSql
from .db import MysqlDb

# Globals
APP_ENV = os.getenv('APP_ENV')
CHAT_NOSQL_COMPARTMENT_ID = os.getenv('CHAT_NOSQL_COMPARTMENT_ID')
CHAT_NOSQL_TABLE_OCID = os.getenv('CHAT_NOSQL_TABLE_OCID')
OCI_MYSQL_HOSTNAME = os.environ.get('OCI_MYSQL_HOSTNAME')
OCI_MYSQL_USERNAME = os.environ.get('OCI_MYSQL_USERNAME')
OCI_MYSQL_PASSWORD = os.environ.get('OCI_MYSQL_PASSWORD')
OCI_MYSQL_DBNAME = os.environ.get('OCI_MYSQL_DBNAME')

class Chat():
   def __init__(self):
      self._mysql_db = MysqlDb(host=OCI_MYSQL_HOSTNAME, user=OCI_MYSQL_USERNAME, 
          passwd=OCI_MYSQL_PASSWORD, db_name=OCI_MYSQL_DBNAME) 
      
      self._nosql = NoSql(compartment_id=CHAT_NOSQL_COMPARTMENT_ID, 
          table_id=CHAT_NOSQL_TABLE_OCID, env=APP_ENV)
      
   def __del__(self):
       if self._mysql_db:
          self._mysql_db.close()
    
   def _get_user_data(self, email: str) -> list:      
      select_sqlstm = f'''
          SELECT id, email, full_name FROM account_user 
              WHERE email = "{email}" AND is_active = 1 LIMIT 1; 
      '''     

      user_data = self._mysql_db.select(select_sqlstm)         

      return user_data
   
   def _validate_classifiedad(self, user_id: int, classifiedad_id: int) -> bool:
      """Checks if the specified classified ad exists and if it's published.

      """
      select_sqlstm = f'''
          SELECT id FROM classifiedad 
              WHERE id = {classifiedad_id} AND status = 'PUBLISHED' 
                  AND user_id = {user_id} LIMIT 1; 
      '''  

      classifiedad_data = self._mysql_db.select(select_sqlstm)     
      
      try:
         classifiedad_id = classifiedad_data[0].get('id')
      except IndexError:
         return False
      else:
         return True
   
   def send_pubmsg(self, message: MessageIn) -> bool:      
      result_user_to = self._get_user_data(email=message.email_to)    
                       
      try:                 
         user_to = result_user_to[0]         
      except IndexError:               
         return False      
    
      to_id = user_to.get('id')
      to_email = user_to.get('email')
      from_email = message.email_from

      if to_email == from_email:
         return False
      
      valid_classifiedad = self._validate_classifiedad(user_id=to_id, classifiedad_id=message.classifiedad_id)

      if not valid_classifiedad:
          return False
      
      nosql_data = {
         'id_from': None,
         'fullname_from': message.fullname_from,
         'email_from': from_email,
         'telephone_from': message.telephone_from,
         'id_to': to_id,
         'fullname_to': user_to.get('full_name'),         
         'classifiedad_id': message.classifiedad_id,
         'message': message.message,
         'date_created': datetime.now()
      }            

      put_status = self._nosql.put(nosql_data)
 
      return put_status
      
    
