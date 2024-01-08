#
# celery-classifiedad/app/modules/ocilog.py
#

import os
import logging
from datetime import datetime

import oci

OCI_LOG_UUID = 'f37603d5-4daa-4afb-a305-46852c0822b2'
LOG_SUBJECT = 'motando-workflow'
OCI_CONFIG_FILE = os.environ.get('OCI_CONFIG_FILE', '/opt/celery-classifiedad/ocisecrt/config')


class OciLogHandler(logging.Handler):
    def __init__(self, log_id: str, env: str)-> None:
        logging.Handler.__init__(self=self)

        if env == 'PRD':
            try:
                signer = oci.auth.signers.InstancePrincipalsSecurityTokenSigner()            
            except:
                signer = oci.auth.signers.get_resource_principals_signer()
                
            self.__ocilog_client = oci.loggingingestion.LoggingClient(config={}, signer=signer)           
        else:
            config = oci.config.from_file(file_location=OCI_CONFIG_FILE)
            self.__ocilog_client = oci.loggingingestion.LoggingClient(config=config)

        self.__log_id = log_id

        self.__ocilog_client.base_client.timeout = None

    def emit(self, record: logging.LogRecord) -> None:
        global OCI_LOG_UUID, LOG_SUBJECT

        log_source = f'{record.pathname}:{record.name}({record.lineno})'

        log_details = oci.loggingingestion.models.PutLogsDetails(
            log_entry_batches=[oci.loggingingestion.models.LogEntryBatch(
                entries=[oci.loggingingestion.models.LogEntry(
                    data=record.msg,
                    id=OCI_LOG_UUID,
                    time=datetime.fromtimestamp(float(record.created))
                )],
                source=log_source,
                type=f'{LOG_SUBJECT} ({record.levelname})',
                subject=LOG_SUBJECT,
                defaultlogentrytime=datetime.now()
            )],
            specversion='1.0'
        )

        self.__ocilog_client.put_logs(
            log_id=self.__log_id,
            put_logs_details=log_details
        )