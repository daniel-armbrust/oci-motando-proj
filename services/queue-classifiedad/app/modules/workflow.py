#
# queue-classifiedad/app/modules/workflow.py
#

import json
import time
import logging as log

from oci.exceptions import ServiceError as OciServiceError

from .storage import Storage
from .queue import Queue
from .db import MysqlDb


class Workflow():
    @property
    def env(self) -> str:
        """Identificador do ambiente (produção ou desenvolvimento).

        """
        return self._env
    
    @env.setter
    def env(self, env: str):
        self._env = env

    @property
    def region_id(self) -> str:
        """Identificador de região do OCI (sa-saopaulo-1, ap-melbourne-1, ...).

        https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm
        """
        return self._region_id
    
    @region_id.setter
    def region_id(self, region_id: str):
        self._region_id = region_id

    @property
    def bucket_src(self):
        """Nome do bucket onde residem as imagens temporárias."""
        return self._bucket_src
    
    @bucket_src.setter
    def bucket_src(self, bucket_src: str):
        self._bucket_src = bucket_src
    
    @property
    def bucket_dst(self):
        """Nome do bucket onde residem as imagens permanentes."""
        return self._bucket_dst
    
    @bucket_dst.setter
    def bucket_dst(self, bucket_dst: str):
        self._bucket_dst = bucket_dst
    
    @property
    def bucket_ns(self):
        """Namespace do bucket.

        https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/understandingnamespaces.htm
        """
        return self._bucket_ns

    @bucket_ns.setter
    def bucket_ns(self, bucket_ns: str):
        self._bucket_ns = bucket_ns
    
    @property
    def db_user(self):
        """Nome de usuário usado para conexão com o banco de dados."""
        return self._db_user
    
    @db_user.setter
    def db_user(self, db_user: str):
        self._db_user = db_user
    
    @property
    def db_passwd(self):
        """Senha usada para conexão com o banco de dados."""
        return self._db_passwd

    @db_passwd.setter
    def db_passwd(self, db_passwd: str):
        self._db_passwd = db_passwd
    
    @property
    def db_name(self):
        """Nome do banco de dados para conexão."""
        return self._db_name
    
    @db_name.setter
    def db_name(self, db_name: str):
        self._db_name = db_name

    @property
    def db_host(self):
        """Hostname para conexão com o banco de dados."""
        return self._db_host
    
    @db_host.setter
    def db_host(self, db_host: str):
        self._db_host = db_host
    
    @property
    def queue_id(self):
        """ID da Queue."""
        return self._queue_id
    
    @queue_id.setter
    def queue_id(self, queue_id: str):
        self._queue_id = queue_id

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
    
    def __compose_msg_list(self, classifiedad_id: str, classifiedad_status: str, msg_list: list):
        msg_template = {'classifiedad_id': classifiedad_id,
            'classifiedad_status': classifiedad_status, 'data': msg_list}

        json_msg = json.dumps(msg_template)

        return json_msg

    def new_task(self, json_msg: str) -> bool:
        """Processa novos anúncios.

        """        
        task_status = False

        img_list = json_msg.get('data')   
        classifiedad_id = json_msg.get('classifiedad_id')
        msg_receipt = json_msg.get('receipt')         

        storage = Storage(region_id=self._region_id, bucket_ns=self._bucket_ns, env=self._env)

        workreq_id_list = []      

        for img_url in img_list:
            log.info(f'Moving image "{img_url}" from bucket "{self._bucket_src}" to bucket "{self._bucket_dst}".')

            workreq_id = storage.move(url_src=img_url, bucket_src=self._bucket_src, 
                bucket_dst=self._bucket_dst)
            
            if workreq_id:
                workreq_id_list.append({'workreq_id': workreq_id, 'img_url': img_url})
            else:
                log.error(f'No WORK REQUEST got from moving an image.')

            # Aguarda alguns segundos antes de seguir com novas chamadas as APIs do
            # OCI. Isso evita problemas de "estouro" de limites. 
            time.sleep(self._api_sleep)               

        if workreq_id_list:
            new_json_msg = self.__compose_msg_list(classifiedad_id=classifiedad_id, 
                classifiedad_status='MOVE', msg_list=workreq_id_list)            
            
            queue = Queue(queue_id=self._queue_id, region_id=self._region_id, env=self._env)
            put_status = queue.put_msg(new_json_msg)

            if put_status is True:
                task_status = queue.delete_msg(msg_receipt)
            else:
                log.error(f'Could not DELETE message in OCI QUEUE (Msg Receipt = {msg_receipt}).')
        
        return task_status  

    def move_task(self, json_msg: str) -> bool:
        """Tarefa para verificar a movimentação das imagens do bucket temporário 
        para o bucket permanente.

        """
        task_status = False

        img_list = json_msg.get('data')      
        classifiedad_id = json_msg.get('classifiedad_id') 
        msg_receipt = json_msg.get('receipt')    

        storage = Storage(region_id=self._region_id, bucket_ns=self._bucket_ns, env=self._env)

        # Lista para armazenar as imagens que serão excluídas.
        delete_url_list = []       
       
        for img_data in img_list:            
            (workreq_id, img_url,) = img_data.get('workreq_id'), img_data.get('img_url')

            workreq_complete = storage.verify_workreq(work_req_id=workreq_id)            

            if workreq_complete is True:
                delete_url_list.append(img_url)
            
        # Compara a qtde de imagens marcadas para exclusão com a lista de imagens
        # para verificação do "work_request". Se foram iguais, todas as imagens foram
        # movimentadas com sucesso.
        total_imgs = len(img_list)
        total_urls_delete = len(delete_url_list)

        if total_imgs == total_urls_delete:
            log.info(f'Trying to DELETE {total_urls_delete} objects.')

            for img_url in delete_url_list: 
                img_filename = img_url[img_url.rindex('/') + 1:]

                try:
                    storage.delete(obj_filename=img_filename, bucket_name=self._bucket_src)                  
                except OciServiceError as e:
                    # FIXME: Problema de ObjectNotFound (404) para alguns objetos que
                    # precisam ser excluídos.
                    log.warn(f'Could not DELETE the object "{img_filename}" from bucket "{self._bucket_src}" ({str(e.code)}).')

                # Aguarda alguns segundos antes de seguir com novas chamadas as APIs do
                # OCI. Isso evita problemas de "estouro" de limites. 
                time.sleep(self._api_sleep)

            new_json_msg = self.__compose_msg_list(classifiedad_id=classifiedad_id, 
                classifiedad_status='PUBLISH', msg_list=delete_url_list)                  
            
            queue = Queue(queue_id=self._queue_id, region_id=self._region_id, env=self._env)
            put_status = queue.put_msg(new_json_msg)

            if put_status is True:
                task_status = queue.delete_msg(msg_receipt)
            else:
                log.error(f'Could not ADD NEW message in OCI QUEUE (Msg Receipt = {msg_receipt}).')
        
        return task_status
    
    def publish_task(self, json_msg: str) -> bool:
        """Tarefa para publicar o anúncio.

        """
        task_status = False

        img_list = json_msg.get('data')      
        classifiedad_id = json_msg.get('classifiedad_id') 
        msg_receipt = json_msg.get('receipt')    

        img_url_prefix = f'https://objectstorage.{self._region_id}.oraclecloud.com/n/{self._bucket_ns}/b/{self._bucket_dst}'

        update_sqlstm_list = []
        
        for img_url in img_list:
            img_filename = img_url[img_url.rindex('/') + 1:]
            new_img_url = img_url_prefix + '/o/' + img_filename

            update_sqlstm = f'''
                UPDATE classifiedad_images SET url = "{new_img_url}" 
                    WHERE classifiedad_id = {classifiedad_id} AND url = "{img_url}" LIMIT 1
            '''
            
            update_sqlstm_list.append(update_sqlstm)
        
        datetime_now = time.strftime('%Y-%m-%d %H:%M:%S')

        update_sqlstm = f'''
            UPDATE classifiedad SET status = "PUBLISHED", updated = "{datetime_now}" 
                WHERE id = {classifiedad_id} LIMIT 1
        '''

        update_sqlstm_list.append(update_sqlstm)

        mysql_db = MysqlDb(host=self._db_host, user=self._db_user, passwd=self._db_passwd, 
            db_name=self._db_name)

        # Atualiza o banco de dados.
        for update_sqlstm in update_sqlstm_list:
            rows_updated = mysql_db.update(update_sqlstm)
            log.info(f'UPDATED {rows_updated} rows in MySQL.')

            if self._env == 'DEV':                
                log.info(f'UPDATE SQL Statement used: {update_sqlstm}'.rstrip())                        

        mysql_db.close()

        # Excluí a mensagem da fila.
        queue = Queue(queue_id=self._queue_id, region_id=self._region_id, env=self._env)
        task_status = queue.delete_msg(msg_receipt)

        if task_status is not True:
            log.error(f'Could not DELETE message in OCI QUEUE (Msg Receipt = {msg_receipt}).')

        return task_status
    
    def update_task(self, json_msg: str) -> bool:
        """Tarefa para atualizar um anúncio.

        """
        task_status = False

        # A lista antiga de imagens está presente no JSON.
        old_img_list = json_msg.get('data')      
        
        classifiedad_id = json_msg.get('classifiedad_id') 
        msg_receipt = json_msg.get('receipt')    

        select_stm = f'''
            SELECT url FROM classifiedad_images WHERE classifiedad_id = {classifiedad_id}
        '''        

        mysql_db = MysqlDb(host=self._db_host, user=self._db_user, passwd=self._db_passwd, 
            db_name=self._db_name)           
        
        new_img_list = []       
        move_img_list = []
        delete_img_list = []

        # Obtém todas as novas imagens do anúncio.
        new_img_list = mysql_db.select(select_stm)   
        mysql_db.close()        

        queue = Queue(queue_id=self._queue_id, region_id=self._region_id, env=self._env)
        
        # String que representa o BUCKET TEMPORÁRIO das imagens.
        bucket_tmp = '/' + self._bucket_src + '/'

        # Imagens novas para processamento.
        for img_url in new_img_list:
            if bucket_tmp in img_url:
                move_img_list.append(img_url)
        else:
            new_json_msg = self.__compose_msg_list(classifiedad_id=classifiedad_id, 
                classifiedad_status='NEW', msg_list=move_img_list)
            task_status = queue.put_msg(new_json_msg)

            if task_status is not True:
                log.error(f'Could not ADD NEW message in OCI QUEUE (NEW TASK).')
                return task_status
                    
        # Imagens que serão processadas pela tarefa de exclusão.
        for img_url in old_img_list:
            if img_url not in new_img_list:
                delete_img_list.append(img_url)
        else:
            new_json_msg = self.__compose_msg_list(classifiedad_id=classifiedad_id, 
                classifiedad_status='DELETE', msg_list=delete_img_list)
            task_status = queue.put_msg(new_json_msg)

            if task_status is not True:
                log.error(f'Could not ADD NEW message in OCI QUEUE (DELETE TASK).')
                return task_status

        # Excluí a mensagem da fila.        
        task_status = queue.delete_msg(msg_receipt)

        if task_status is not True:
            log.error(f'Could not DELETE message in OCI QUEUE (Msg Receipt = {msg_receipt}).') 

        return task_status
    
    def delete_task(self, json_msg: str) -> bool:
        """Tarefa para excluír imagens de um anúncio.

        """
        task_status = False

        img_list = json_msg.get('data')              
        classifiedad_id = json_msg.get('classifiedad_id')        
        msg_receipt = json_msg.get('receipt')        

        storage = Storage(region_id=self._region_id, bucket_ns=self._bucket_ns, env=self._env)

        for img_url in img_list: 
            img_filename = img_url[img_url.rindex('/') + 1:]

            try:
                storage.delete(obj_filename=img_filename, bucket_name=self._bucket_src)                  
            except OciServiceError as e:
                # FIXME: Problema de ObjectNotFound (404) para alguns objetos que
                # precisam ser excluídos.
                log.error(f'Could not DELETE the object "{img_filename}" from bucket "{self._bucket_src}" ({str(e.code)}).')
            
            try:
                storage.delete(obj_filename=img_filename, bucket_name=self._bucket_dst)                  
            except OciServiceError as e:
                # FIXME: Problema de ObjectNotFound (404) para alguns objetos que
                # precisam ser excluídos.
                log.error(f'Could not DELETE the object "{img_filename}" from bucket "{self._bucket_dst}" ({str(e.code)}).')
                    
            # Aguarda alguns segundos antes de seguir com novas chamadas as APIs do
            # OCI. Isso evita problemas de "estouro" de limites. 
            time.sleep(self._api_sleep)                

        mysql_db = MysqlDb(host=self._db_host, user=self._db_user, passwd=self._db_passwd, 
            db_name=self._db_name)

        delete_stm_list = [
            f'''
                DELETE FROM classifiedad_images WHERE classifiedad_id = {classifiedad_id}
            ''',
            f'''
                DELETE FROM classifiedad WHERE id = {classifiedad_id}
            ''' 
        ]

        for delete_stm in delete_stm_list:            
            rows_deleted = mysql_db.delete(delete_stm)
            log.info(f'DELETED {rows_deleted} rows in MySQL.')

            if self._env == 'DEV':                
                log.info(f'DELETE SQL Statement used: {delete_stm}'.rstrip())     

        # Excluí a mensagem da fila.
        queue = Queue(queue_id=self._queue_id, region_id=self._region_id, env=self._env)
        task_status = queue.delete_msg(msg_receipt)

        if task_status is not True:
            log.error(f'Could not DELETE message in OCI QUEUE (Msg Receipt = {msg_receipt}).')

        return task_status