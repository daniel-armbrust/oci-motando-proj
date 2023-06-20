#
# queue-classifiedad/app/modules/db.py
#

import logging as log

import mysql.connector


class MysqlDb():
    def __init__(self, host: str = None, port: int = 3306, user: str = None, passwd: str = None, db_name: str = None):
        """
        
        """
        self._conn = mysql.connector.connect(host=host, user=user, password=passwd, database=db_name)
    
    def __get_cursor(self):
        return self._conn.cursor()      

    def __del__(self):
        self.close()
   
    def close(self):
        if self._conn:
            self._conn.close() 

    def update(self, stm: str) -> int:
        """
        
        """
        cursor = self.__get_cursor()

        result = None
        
        try:
            result = cursor.execute(stm)
        except mysql.connector.Error as err:
            log.error('Could execute SQL QUERY: {}'.format(err))            
        else:            
            self._conn.commit()
        
        cursor.close()

        if result is None:
            return cursor.rowcount
        else:
            return 0


    
        
        
        


