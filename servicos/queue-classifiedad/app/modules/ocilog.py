#
# queue-classifiedad/app/modules/ocilog.py
#

import logging
from datetime import datetime

import oci

# Somente um identificador.
OCI_LOG_UUID = 'f37603d5-4daa-4afb-a305-46852c0822b2'

# Origem do log.
LOG_SUBJECT = 'motando-workflow'


class OciLogHandler(logging.Handler):
    def __init__(self, log_id: str, env: str)-> None:        
        logging.Handler.__init__(self=self)

        if env == 'PRD':
            signer = oci.auth.signers.InstancePrincipalsSecurityTokenSigner()
            self.__ocilog_client = oci.loggingingestion.LoggingClient(signer=signer)
        else:
            config = oci.config.from_file()
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
                type=record.levelname,
                subject=LOG_SUBJECT,
                defaultlogentrytime=datetime.now()
            )],
            specversion='1.0'
        )

        self.__ocilog_client.put_logs(
            log_id=self.__log_id,
            put_logs_details=log_details
        )