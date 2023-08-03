#
# celery-classifiedad/app/classifiedad.py
#

import logging as log
import time

from .storage import Storage
from .db import MysqlDb


class DbClassifiedad():
    def __init__(self, user: str, passwd: str, dbname: str, host: str):
        self._mysql_db = MysqlDb(user=user, passwd=passwd, dbname=dbname, 
                                 host=host)
        
    def close(self):
        if self._mysql_db:
            self._mysql_db.close()
        
    def get_images_url(self, classifiedad_id: int):
        select_sqlstm = f'''
            SELECT url FROM classifiedad_images 
                LEFT JOIN classifiedad ON classifiedad.id = classifiedad_images.classifiedad_id 
            WHERE classifiedad_id = {classifiedad_id} AND classifiedad.status = 'NEW'      
        '''

        img_list = self._mysql_db.select(select_sqlstm)          

        return img_list

    def update_image_url(self, classifiedad_id: int, old_img_url: str, new_img_url: str):     
        update_sqlstm = f'''
            UPDATE classifiedad_images SET url = "{new_img_url}" 
                WHERE classifiedad_id = {classifiedad_id} AND url = "{old_img_url}" LIMIT 1
        '''

        update_status = self._mysql_db.update(update_sqlstm)        

        if update_status:
            return True
        else:            
            return False
    
    def publish(self, classifiedad_id: int):        
        datetime_now = time.strftime('%Y-%m-%d %H:%M:%S')

        update_sqlstm = f'''
            UPDATE classifiedad SET status = "PUBLISHED", updated = "{datetime_now}" 
                WHERE id = {classifiedad_id} LIMIT 1
        '''

        update_status = self._mysql_db.update(update_sqlstm)        

        if update_status:
            return True
        else:            
            return False


class StorageClassifiedad():
    @property
    def api_sleep(self):        
        return self._api_sleep

    @api_sleep.setter
    def api_sleep(self, secs: int = 2):
        if secs < 2:            
            secs = 2      
            log.warn(f'Force SLEEP to {secs} seconds between OCI API CALLS.')      
        self._api_sleep = secs  

    def __init__(self, region_id: str, bucket_ns: str, env: str):
        self._storage = Storage(region_id=region_id, bucket_ns=bucket_ns, env=env) 
    
    def move_img(self, img_url: str, bucket_src: str, bucket_dst: str):
        workreq_id = self._storage.move(url_src=img_url, bucket_src=bucket_src, 
                                        bucket_dst=bucket_dst)
        time.sleep(self._api_sleep)

        return workreq_id
    
    def workreq_status(self, workreq_id: str) -> bool:
        workreq_status = self._storage.verify_workreq(workreq_id=workreq_id)

        time.sleep(self._api_sleep)

        return workreq_status
    
    def list_delete(self, bucket_name: str, obj_list: list) -> bool:
        for obj_filename in obj_list:
            self._storage.delete(obj_filename=obj_filename, bucket_name=bucket_name)
            time.sleep(self._api_sleep)


class NewClassifiedad():
    @property
    def env(self) -> str:
        return self._env
    
    @env.setter
    def env(self, env: str):
        self._env = env
    
    @property
    def region_id(self) -> str:
        """OCI region identifier (sa-saopaulo-1, ap-melbourne-1, ...).

        https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm
        """
        return self._region_id
    
    @region_id.setter
    def region_id(self, region_id: str):
        self._region_id = region_id

    @property
    def bucket_src(self):
        """Source Bucket name where the temporary images reside."""
        return self._bucket_src
    
    @bucket_src.setter
    def bucket_src(self, bucket_src: str):
        self._bucket_src = bucket_src
    
    @property
    def bucket_dst(self):
        """Destination Bucket name where the permanent images will reside."""
        return self._bucket_dst
    
    @bucket_dst.setter
    def bucket_dst(self, bucket_dst: str):
        self._bucket_dst = bucket_dst
    
    @property
    def bucket_ns(self):
        """OCI Bucket Namespace.

        https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/understandingnamespaces.htm
        """
        return self._bucket_ns

    @bucket_ns.setter
    def bucket_ns(self, bucket_ns: str):
        self._bucket_ns = bucket_ns
    
    @property
    def db_user(self):
        """Motando application Database username."""
        return self._db_user
    
    @db_user.setter
    def db_user(self, db_user: str):
        self._db_user = db_user
    
    @property
    def db_passwd(self):
        """Motando application Database password."""
        return self._db_passwd

    @db_passwd.setter
    def db_passwd(self, db_passwd: str):
        self._db_passwd = db_passwd
    
    @property
    def db_name(self):
        """Motando application Database name (schema)."""
        return self._db_name
    
    @db_name.setter
    def db_name(self, db_name: str):
        self._db_name = db_name
    
    @property
    def db_host(self):
        """Motando application Database host."""
        return self._db_host
    
    @db_host.setter
    def db_host(self, db_host: str):
        self._db_host = db_host
    
    @property
    def api_sleep(self):
        """Tempo minimo entre API CALLS."""
        return self._api_sleep

    @api_sleep.setter
    def api_sleep(self, secs: int = 2):
        if secs < 2:            
            secs = 2      
            log.warn(f'Force SLEEP to {secs} seconds between OCI API CALLS.')      
        self._api_sleep = secs  

    def __init__(self, classifiedad_id: int):
        self._workreq_list = []            
        self._classifiedad_id = classifiedad_id    

    def new(self):
        """Starting publishing a NEW classifiedad.
        
        """
        db = DbClassifiedad(user=self._db_user, passwd=self._db_passwd,
                            dbname=self._db_name, host=self._db_host)
        
        img_url_list = db.get_images_url(classifiedad_id=self._classifiedad_id)
        db.close()

        if not img_url_list:
            log.warn(f'There are no images to be processed for the  classifiedadid "{self._classifiedad_id}".')
        else:
            storage = StorageClassifiedad(region_id=self._region_id, 
                                          bucket_ns=self._bucket_ns, env=self._env)
            
            storage.api_sleep = self._api_sleep

            for img_url in img_url_list:
                workreq_id = storage.move_img(img_url=img_url, bucket_src=self._bucket_src, 
                                              bucket_dst=self._bucket_dst)
                if workreq_id:
                    self._workreq_list.append({'workreq_id': workreq_id, 'img_url': img_url})
                else:
                    log.error(f'No WORK REQUEST ID returned when tried the move operation.')  

    def done(self):
        """Checks if all work requests are finished.
        
        """
        done_count = 0

        storage = StorageClassifiedad(region_id=self._region_id, 
                                      bucket_ns=self._bucket_ns, env=self._env)
        
        storage.api_sleep = self._api_sleep

        for workreq_data in self._workreq_list:            
            workreq_status = storage.workreq_status(
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
        publish_status = False

        db = DbClassifiedad(user=self._db_user, passwd=self._db_passwd, 
                            dbname=self._db_name, host=self._db_host)
        
        for workreq_data in self._workreq_list:
            old_img_url = workreq_data.get('img_url')

            img_url_prefix = f'https://objectstorage.{self._region_id}.oraclecloud.com/n/{self._bucket_ns}/b/{self._bucket_dst}'

            img_filename = old_img_url[old_img_url.rindex('/') + 1:]
            new_img_url = img_url_prefix + '/o/' + img_filename

            update_status = db.update_image_url(classifiedad_id=self._classifiedad_id, 
                                                old_img_url=old_img_url, new_img_url=new_img_url)
            
            if not update_status:
                log.error(f'Cannot UPDATE the new image URL. Old "{old_img_url}" to New "{new_img_url}".')
            else:
                img_delete_list.append(img_filename)                

        if len(self._workreq_list) == len(img_delete_list):
            storage = StorageClassifiedad(region_id=self._region_id,
                                          bucket_ns=self._bucket_ns, env=self._env)
            
            storage.api_sleep = self._api_sleep

            storage.list_delete(bucket_name=self._bucket_src, obj_list=img_delete_list)

            publish_status = db.publish(classifiedad_id=self._classifiedad_id)            

        db.close()
        
        return publish_status


        

        






                       
    