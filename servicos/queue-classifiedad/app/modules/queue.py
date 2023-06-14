#
# queue-classifiedad/app/modules/queue.py
#

import json
import oci


class Queue():
    """
    https://docs.oracle.com/en-us/iaas/tools/python/2.91.0/api/queue.html
    """
    # Controla a qtde máxima de mensagens retornadas. O limite
    # máximo são 20 mensagens.
    __MAX_MESSAGES = 20

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

        self.__client.base_client.timeout = None

    def get_all_messages(self, timeout_secs: int = 30):
        """Obtém todas as mensagens existentes na fila.

        Args:
            timeout_secs: Período de tempo máximo no qual um consumidor pode aguardar
        ao tentar obter as mensagens da fila. O valor pode estar compreendido entre 0 a
        30 segundos.
        """
        # visibility_in_seconds: igual a zero, tem a função de "espiar" a fila,
        # obtendo todas as mensagens sem escondê-las por um período de
        # tempo. Lembrando que esta ação também incrementa a propriedade
        # "delivery count" (+1).
        resp = self.__client.get_messages(queue_id=self.__queue_id,
            visibility_in_seconds=0, timeout_in_seconds=timeout_secs,
            limit=self.__MAX_MESSAGES)

        msg_list = []
        
        if resp.status == 200:
            for msg_data in resp.data.messages:
                msg_dict = json.loads(msg_data.content)
                msg_dict.update({'id': msg_data.id, 'receipt': msg_data.receipt})
                msg_list.append(msg_dict)

        return msg_list

    def put_msg(self, msg: str):
        """Insere uma mensagem na fila.

        """
        resp = self.__client.put_messages(queue_id=self.__queue_id, 
            put_messages_details=oci.queue.models.PutMessagesDetails(
                messages=[oci.queue.models.PutMessagesDetailsEntry(content=msg)]
            )
        )
        
        # HTTP - 200 OK
        if resp.status == 200:
            return True
        else:
            return False

    def update_msg(self, msg_receipt: str):
        pass

    def delete_msg(self, receipt: str):
        """Excluí da fila a mensagem especificada no parâmetro.
        
        """
        resp = self.__client.delete_message(queue_id=self.__queue_id, 
            message_receipt=receipt)
        
        # HTTP - 204 No Content 
        if resp.status == 204:
            return True
        else:
            return False      