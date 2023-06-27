#
# classifiedad/queue.py
#

import json
import oci


class ClassifiedAdQueue():
    @property
    def classifiedad_id(self):
        return self.__classifiedad_id

    @classifiedad_id.setter
    def classifiedad_id(self, classifiedad_id: int):
        self.__classifiedad_id = classifiedad_id

    @property
    def classifiedad_status(self):
        return self.__classifiedad_status

    @classifiedad_status.setter
    def classifiedad_status(self, status: str):
        valid_status = ('NEW', 'DELETE', 'INACTIVE', 'UPDATE',)

        if status not in valid_status:
            raise ValueError(f'Invalid status value: "{status}"')
        else:
            self.__classifiedad_status = status       

    def __init__(self, queue_id: str, region_id: str, env: str):
        self.__queue_id = queue_id

        # https://docs.oracle.com/en-us/iaas/Content/queue/messages.htm#messages__messages-endpoint
        service_endpoint = f'https://cell-1.queue.messaging.{region_id}.oci.oraclecloud.com'

        if env == 'PRD':
            signer = oci.auth.signers.InstancePrincipalsSecurityTokenSigner()
            self.__client = oci.queue.QueueClient(signer=signer, service_endpoint=service_endpoint)
        else:        
            config = oci.config.from_file()
            self.__client = oci.queue.QueueClient(config=config, service_endpoint=service_endpoint)
        
    def _compose_msg_list(self, msg_list: list = None):        
        msg_template = {'classifiedad_id': self.__classifiedad_id,
            'classifiedad_status': self.__classifiedad_status, 'data': msg_list}        

        json_msg = json.dumps(msg_template)

        return json_msg

    def put_list(self, msg_list: list = None):
        json_msg = self._compose_msg_list(msg_list)

        resp = self.__client.put_messages(queue_id=self.__queue_id,
            put_messages_details=oci.queue.models.PutMessagesDetails(
                messages=[oci.queue.models.PutMessagesDetailsEntry(content=json_msg)]
            )
        )

        # HTTP - 200 OK
        if resp.status == 200:
            return resp.data.messages[0].id
        else:
            return None
    
    def put(self):
        json_msg = self._compose_msg_list()

        resp = self.__client.put_messages(queue_id=self.__queue_id,
            put_messages_details=oci.queue.models.PutMessagesDetails(
                messages=[oci.queue.models.PutMessagesDetailsEntry(content=json_msg)]
            )
        )

        # HTTP - 200 OK
        if resp.status == 200:
            return resp.data.messages[0].id
        else:
            return None