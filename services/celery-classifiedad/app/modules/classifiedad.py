#
# celery-classifiedad/app/classifiedad.py
#

import logging as log
import time

from oci.exceptions import ServiceError as OciServiceError

from modules.storage import OciStorage
from modules.db import MysqlDb


class Database():
    def __init__(self, db_user: str, db_passwd: str, db_name: str, db_host: str):              
        self._mysql_db = MysqlDb(user=db_user,
                                 passwd=db_passwd, 
                                 dbname=db_name,
                                 host=db_host)

class ClassifiedadStorage():
    def __init__(self, env: str, region_id: str, bucket_ns: str, api_sleep: int):            
        self._oci_storage = OciStorage(env=env,
                                       region_id=region_id,
                                       bucket_ns=bucket_ns)
        
        if (api_sleep < 2):
            self._api_sleep = 2
        else:
            self._api_sleep = api_sleep
        
    def move(self, obj_filename: str, bucket_src: str, bucket_dst: str):        
        workreq_id = self._oci_storage.move(obj_filename=obj_filename, 
                                            bucket_src=bucket_src,
                                            bucket_dst=bucket_dst)
        
        time.sleep(self._api_sleep)

        return workreq_id
    
    def workreq_status(self, workreq_id: str) -> bool:
        workreq_status = self._oci_storage.verify_workreq(workreq_id=workreq_id)

        time.sleep(self._api_sleep)

        return workreq_status

    def delete(self, obj_filename: str, bucket_name: str):
        deleted = False

        try:
            self._oci_storage.delete(obj_filename=obj_filename, 
                                     bucket_name=bucket_name)
        except OciServiceError as e:
            log.warn(f'Could not DELETE the object "{obj_filename}"' + \
                     f' from bucket "{bucket_name}" ({str(e.code)}).')
        else:
            deleted = True

        time.sleep(self._api_sleep)

        return deleted

class Classifiedad(Database, ClassifiedadStorage):    
    def __init__(self, **kwargs):        
        self._workreq_list = []                

        self._classifiedad_id = kwargs['classifiedad_id'] 
        self._region_id = kwargs['region_id'] 
        self._bucket_ns = kwargs['bucket_ns'] 
        self._bucket_tmp = kwargs['bucket_tmp'] 
        self._bucket_img = kwargs['bucket_img'] 

        Database.__init__(self, 
                          db_user=kwargs['db_user'],
                          db_passwd=kwargs['db_passwd'],                        
                          db_name=kwargs['db_name'],
                          db_host=kwargs['db_host'],)
        
        ClassifiedadStorage.__init__(self, 
                         env=kwargs['env'],                         
                         region_id=self._region_id,
                         bucket_ns=self._bucket_ns,                       
                         api_sleep=kwargs['api_sleep'])        
           
    
    def __del__(self):
        if self._mysql_db:
            self._mysql_db.close()
    
    def _get_images_url(self, classifiedad_status: str) -> list:
        select_sqlstm = f'''
           SELECT url FROM classifiedad_images 
                LEFT JOIN classifiedad ON classifiedad.id = classifiedad_images.classifiedad_id 
            WHERE classifiedad_id = {self._classifiedad_id} 
                AND classifiedad.status = '{classifiedad_status}'
        '''

        img_list = self._mysql_db.select(select_sqlstm)

        return img_list
    
    def new(self):
        """Starting publishing a NEW classifiedad.
        
        """
        img_list = self._get_images_url(classifiedad_status='NEW')

        if not img_list:
            log.warn(f'There are no images to be processed for the classifiedad_id "{self._classifiedad_id}".')
            return None
        
        for img_url in img_list:
            obj_filename = img_url[img_url.rindex('/') + 1:]

            workreq_id = ClassifiedadStorage.move(self,
                                                  obj_filename=obj_filename, 
                                                  bucket_src=self._bucket_tmp, 
                                                  bucket_dst=self._bucket_img)                       
            if workreq_id:
                self._workreq_list.append({'workreq_id': workreq_id, 'img_url': img_url})
            else:
                log.error(f'No WORK REQUEST ID returned when tried the move operation.')        
    
    def update(self, old_img_list: list):
        """Update the classifiedad.
        
        """       
        new_img_list = self._get_images_url(classifiedad_status='UPDATE')

        if not new_img_list:
            log.warn(f'There are no images to be processed for the classifiedad_id "{self._classifiedad_id}".')
            return None       
      
        # New images for processing.
        for img_url in new_img_list:
            if f'/{self._bucket_tmp}/' in img_url:
                img_filename = img_url[img_url.rindex('/') + 1:]

                workreq_id = ClassifiedadStorage.move(self,
                                                      obj_filename=img_filename, 
                                                      bucket_src=self._bucket_tmp, 
                                                      bucket_dst=self._bucket_img)     
                if workreq_id:
                    self._workreq_list.append({'workreq_id': workreq_id, 
                                               'img_url': img_url})
                else:
                    log.error(f'No WORK REQUEST ID returned when tried the move operation.')        

        # Images that will be delete.
        deleted = False

        for img_url in old_img_list:
            if img_url not in new_img_list:
                img_filename = img_url[img_url.rindex('/') + 1:]

                if f'/{self._bucket_tmp}/' in img_url:
                    deleted = ClassifiedadStorage.delete(self, 
                                                         obj_filename=img_filename, 
                                                         bucket_name=self._bucket_tmp)
                else:
                    deleted = ClassifiedadStorage.delete(self, 
                                               obj_filename=img_filename, 
                                               bucket_name=self._bucket_img)
                
                if not deleted:
                    log.error(f'Could not delete the image "{img_filename}"' + \
                              f'from bucket {self._bucket_tmp}.')


    def delete(self, classifiedad_id: int):
        """Delete the classifiedad.
        
        """       
        delete_img_list = self._get_images_url(classifiedad_status='DELETE')

        for img_url in delete_img_list: 
            img_filename = img_url[img_url.rindex('/') + 1:]

            ClassifiedadStorage.delete(self,
                                       obj_filename=img_filename,
                                       bucket_name=self._bucket_img)
            
            delete_stm_list = [
                f'''
                    DELETE FROM classifiedad_images WHERE classifiedad_id = {classifiedad_id}
                 ''',
                f'''
                    DELETE FROM classifiedad WHERE id = {classifiedad_id}
                 '''
            ]




    def done(self):   
        """Checks if all work requests are finished.
        
        """
        done_count = 0     

        for workreq_data in self._workreq_list:            
            workreq_status = ClassifiedadStorage.workreq_status(self,
                                                                workreq_id=workreq_data.get('workreq_id'))                

            if workreq_status is True:
                done_count += 1

        if len(self._workreq_list) == done_count:
            return True
        else:
            return False
    
    def publish(self):
        """Publishes the NEW classifiedad.

        """
        img_delete_list = []       

        for workreq_data in self._workreq_list:
            old_img_url = workreq_data.get('img_url')

            img_url_prefix = f'https://objectstorage.{self._region_id}.oraclecloud.com/n/{self._bucket_ns}/b/{self._bucket_img}'

            img_filename = old_img_url[old_img_url.rindex('/') + 1:]

            new_img_url = f'{img_url_prefix}/o/{img_filename}'

            update_sqlstm = f'''
                UPDATE classifiedad_images SET url = "{new_img_url}" 
                    WHERE classifiedad_id = {self._classifiedad_id} AND url = "{old_img_url}" LIMIT 1
            '''

            updated = self._mysql_db.update(update_sqlstm)

            if not updated:
                log.error(f'Cannot UPDATE the new image URL. Old "{old_img_url}" to New "{new_img_url}".')
            else:
                img_delete_list.append(img_filename)    

        if len(self._workreq_list) == len(img_delete_list):           
            datetime_now = time.strftime('%Y-%m-%d %H:%M:%S')

            update_sqlstm = f'''
                UPDATE classifiedad SET status = "PUBLISHED", updated = "{datetime_now}" 
                    WHERE id = {self._classifiedad_id} LIMIT 1
            '''

            updated = self._mysql_db.update(update_sqlstm)       

            if not updated:
                log.error(f'Could not UPDATE the classifiedad (id={self._classifiedad_id}).')
           
            for img in img_delete_list:
                ClassifiedadStorage.delete(self, 
                                           obj_filename=img, 
                                           bucket_name=self._bucket_tmp)  