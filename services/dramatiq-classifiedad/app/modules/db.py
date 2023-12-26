#
# dramatiq-classifiedad/app/modules/db.py
#

import logging as log

import mysql.connector


class MysqlDb():
    def __init__(self, host: str = None, port: int = 3306, user: str = None, passwd: str = None, dbname: str = None):       
        self._conn = mysql.connector.connect(host=host, user=user, password=passwd, database=dbname)
    
    def __get_cursor(self, dictionary: bool = False):
        return self._conn.cursor(dictionary=dictionary)      

    def __del__(self):
        self.close()
   
    def close(self):
        if self._conn:
            self._conn.close() 

    def update(self, stm: str) -> int:        
        cursor = self.__get_cursor()

        result = None
        
        try:
            result = cursor.execute(stm)
        except mysql.connector.Error as err:
            log.error('Could NOT execute the SQL UPDATE Statement: {}'.format(err))            
        else:            
            self._conn.commit()
        
        cursor.close()

        if result is None:
            return cursor.rowcount
        else:
            return 0
    
    def select(self, stm: str) -> list:        
        cursor = self.__get_cursor()

        result = None
        item_list = []

        try:
            result = cursor.execute(stm)
        except mysql.connector.Error as err:
            log.error('Could NOT execute the SQL SELECT Statement: {}'.format(err))            
        else:            
            result = cursor.fetchall()
        
        for item in result:
            item_list.append(item[0])
        
        return item_list
    
    def delete(self, stm: str) -> list:        
        cursor = self.__get_cursor()

        result = None        

        try:
            result = cursor.execute(stm)
        except mysql.connector.Error as err:
            log.error('Could NOT execute the SQL DELETE Statement: {}'.format(err))            
        else:
            self._conn.commit()
            
        cursor.close()

        if result is None:
            return cursor.rowcount
        else:
            return 0