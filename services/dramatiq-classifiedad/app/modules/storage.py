#
# dramatiq-classifiedad/app/modules/storage.py
#

import os
import logging as log

import oci

OCI_CONFIG_FILE = os.environ.get('OCI_CONFIG_FILE', '/opt/dramatiq-classifiedad/ocisecrt/config')

class OciStorage():
    def __init__(self, region_id: str, bucket_ns: str, env: str):
        self.__region_id = region_id
        self.__bucket_ns = bucket_ns
        
        if env == 'PRD':
            signer = oci.auth.signers.InstancePrincipalsSecurityTokenSigner()
            self.__client = oci.object_storage.ObjectStorageClient(config={}, signer=signer)
        else:
            config = oci.config.from_file(file_location=OCI_CONFIG_FILE)
            self.__client = oci.object_storage.ObjectStorageClient(config=config)
        
        self.__client.base_client.timeout = None
            
    def move(self, obj_filename: str, bucket_src: str, bucket_dst: str):       
        copy_details = oci.object_storage.models.CopyObjectDetails(
            destination_bucket=bucket_dst, destination_namespace=self.__bucket_ns,
            destination_object_name=obj_filename, destination_region=self.__region_id,
            source_object_name=obj_filename)
        
        resp = self.__client.copy_object(bucket_name=bucket_src, namespace_name=self.__bucket_ns,
            copy_object_details=copy_details)
            
        work_req_id = None

        if resp.status == 202:
            work_req_id = resp.headers.get('opc-work-request-id')
        else:
            log.error(f'Error to MOVE the file "{obj_filename}" from bucket ' + \
                      f'"{bucket_src}" to "{bucket_dst}" (Return code = {resp.status}).')
        
        return work_req_id
    
    def verify_workreq(self, workreq_id: str) -> bool:
        """Check if the "work_request" was completed.

        """
        resp = self.__client.get_work_request(work_request_id=workreq_id)

        if resp.status == 200 and resp.data.status == 'COMPLETED':
            return True
        else:            
            return False
    
    def delete(self, obj_filename: str, bucket_name: str) -> bool:
        """Deletes the object from bucket.

        https://docs.oracle.com/en-us/iaas/api/#/en/objectstorage/20160918/Object/DeleteObject
        """

        resp = self.__client.delete_object(namespace_name=self.__bucket_ns, 
            bucket_name=bucket_name, object_name=obj_filename)               
        
        if resp.status == 204:
            return True
        else:
            log.error(f'Could not DELETE - Object Filename: "{obj_filename}", ' + \
                      'Bucket: "{bucket_name}", Return code = {resp.status}.')                        
            return False
