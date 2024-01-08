#
# motando/ocilog.py
#

import os
import logging
from datetime import datetime

from django.conf import settings

import oci

# Globals
OCI_LOG_UUID = 'd0395ad0-1a75-11ee-be56-0242ac120002'
OCI_CONFIG_FILE = os.environ.get('OCI_CONFIG_FILE', '/opt/webapp/ocisecrt/config')

class OciLogHandler(logging.Handler):
    def __init__(self) -> None: 
        logging.Handler.__init__(self=self)

        self.__log_id = settings.OCI_LOG_ID
        env = settings.APP_ENV

        if env == 'PRD':
            try:
                signer = oci.auth.signers.InstancePrincipalsSecurityTokenSigner()            
            except:
                signer = oci.auth.signers.get_resource_principals_signer()
                
            self.__ocilog_client = oci.loggingingestion.LoggingClient(config={}, signer=signer)
        else:                        
            config = oci.config.from_file(file_location=OCI_CONFIG_FILE)
            self.__ocilog_client = oci.loggingingestion.LoggingClient(config=config)                      

        self.__ocilog_client.base_client.timeout = None

    def emit(self, record: logging.LogRecord) -> None:
        global OCI_LOG_UUID
                   
        log_details = oci.loggingingestion.models.PutLogsDetails(
            log_entry_batches=[oci.loggingingestion.models.LogEntryBatch(
                entries=[oci.loggingingestion.models.LogEntry(
                    data=f'{{"process": {record.processName}, "processNum": {record.process}, "level": {record.levelname}, "message": {record.message}}}',
                    id=OCI_LOG_UUID,
                    time=datetime.fromtimestamp(float(record.created))
                )],
                source=f'{record.name}',
                type=f'{record.name} - {record.levelname}',
                subject='',
                defaultlogentrytime=datetime.now()
            )],
            specversion='1.0'
        )
        
        self.__ocilog_client.put_logs(
            log_id=self.__log_id,
            put_logs_details=log_details
        )
       