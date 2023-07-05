#
# chat/app/modules/nosql.py
#

from datetime import datetime
import logging as log

import oci


class NoSql():
    def __init__(self, compartment_id: str, table_id: str, env: str):
        self._compartment_id = compartment_id
        self._table_id = table_id

        if env == 'PRD':
            signer = oci.auth.signers.InstancePrincipalsSecurityTokenSigner()
            self.__client = oci.nosql.NosqlClient(signer=signer)
        else:
            config = oci.config.from_file()
            self.__client = oci.nosql.NosqlClient(config=config)
        
        self.__client.base_client.timeout = None
    
    def query(self, data):
        pass

    def put(self, data):
        update_details = oci.nosql.models.UpdateRowDetails(
            compartment_id=self._compartment_id, 
            option=oci.nosql.models.UpdateRowDetails.OPTION_IF_ABSENT,
            value=data
        )
                
        try:
            resp = self.__client.update_row(table_name_or_id=self._table_id, 
                update_row_details=update_details)
        except oci.exceptions.TransientServiceError as e:
            log.error(f'Could not PUT data into NoSQL table: {e}')
            return False

        if resp.status == 200:
            return True
        else:
            return False