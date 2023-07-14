#
# chat/app/modules/chat.py
#

import os
from datetime import datetime
import logging as log

from .models import NewMessageIn
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
    
   def _get_user_data(self, email: str = None, classifiedad_id: int = None) -> list:  
      if classifiedad_id:
         select_sqlstm = f'''
             SELECT account_user.id, account_user.email, account_user.fullname, account_userprofile.telephone 
                 FROM account_user
             INNER JOIN account_userprofile ON account_userprofile.user_id = account_user.id
             INNER JOIN classifiedad ON classifiedad.user_id = account_user.id
             WHERE (classifiedad.id = {classifiedad_id} AND classifiedad.status = "PUBLISHED") 
                 AND account_user.is_active = 1 LIMIT 1;
         '''
      elif email:
         select_sqlstm = f'''
             SELECT account_user.id, account_user.email, account_user.fullname, account_userprofile.telephone 
                 FROM account_user
             INNER JOIN account_userprofile ON account_userprofile.user_id = account_user.id
             INNER JOIN classifiedad ON classifiedad.user_id = account_user.id
             WHERE account_user.email = "{email}" AND account_user.is_active = 1 LIMIT 1;
         '''
      else:
         return None
          
      user_data = self._mysql_db.select(select_sqlstm)         

      return user_data
   
   def _exists_message(self, email: str, classifiedad_id: int) -> int:
      """

      """
      select_sqlstm = f'''
          SELECT id FROM motando_chats 
              WHERE user_from_email = "{email}" AND classifiedad_id = {classifiedad_id}
      '''      

      result = self._nosql.query(select_sqlstm)

      if result:
         return result[0]['id']
      else:
         return None

   def read_messages(self, user_to_id: str = None, user_from_id: str = None):
      if user_to_id:
         select_sqlstm = f'''
             SELECT id, classifiedad_id, user_from_fullname, user_from_email, 
                    user_from_telephone, messages 
             FROM motando_chats WHERE user_to_id = {user_to_id}
         '''      

      elif user_from_id:
         select_sqlstm = f'''
             SELECT id, classifiedad_id, user_from_fullname, user_from_email, 
                    user_from_telephone, messages 
             FROM motando_chats WHERE user_from_id = {user_from_id}
         '''        

      else:
         return None     
            
      result = self._nosql.query(select_sqlstm)

      if result:
         for message_data in result:
            print(message_data)
    
      return result

   def new_message(self, message: NewMessageIn) -> bool:      
      # Get details from the owner of the classifiedad.
      user_to_props = self._get_user_data(classifiedad_id=message.classifiedad_id)    
      
      try:                 
         user_to = user_to_props[0]         
      except (IndexError, TypeError,):               
         return False      
      
      # Check if the user that is trying to send a message exists.
      user_from_props = self._get_user_data(email=message.user_from_email)
      
      try:
         user_from = user_from_props[0]         
      except IndexError:               
         user_from = {'id': None, 'fullname': message.user_from_fullname, 
                      'email': message.user_from_email, 'telephone': message.user_from_telephone}
      
      datetime_now = datetime.now()      

      # Check if this user already sent a message before.
      chat_id = self._exists_message(email=user_from.get('email'), classifiedad_id=message.classifiedad_id)  

      if chat_id:
         user_fullname = user_from.get('fullname')

         update_sqlstm = f'''
             UPDATE motando_chats j ADD j.messages 
                {{
                    "from": "{user_fullname}", 
                    "text": "{message.message}",
                    "timestamp": "{datetime_now}"
                }}
             WHERE id = {chat_id} AND classifiedad_id = {message.classifiedad_id}
         '''         

         updated_rows = self._nosql.query(update_sqlstm)         
         
         if updated_rows and (updated_rows[0]['NumRowsUpdated'] > 0):
            return  True

      else:
         put_data = {
            'user_from_id': user_from.get('id', None),
            'user_from_fullname': user_from.get('fullname'),
            'user_from_email': user_from.get('email'),
            'user_from_telephone': user_from.get('telephone', None),
            'user_to_id': user_to.get('id'),
            'user_to_fullname': user_to.get('fullname'),        
            'user_to_email': user_to.get('email'),        
            'user_to_telephone': user_to.get('telephone'),        
            'classifiedad_id': message.classifiedad_id,
            'messages': [
               {
                  'from': user_from.get('fullname'), 
                  'text': message.message, 
                  'timestamp': datetime_now
               }
            ]        
         }     

         oper_status = self._nosql.put(put_data)

         return oper_status