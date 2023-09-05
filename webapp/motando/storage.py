#
# motando/storage.py
#

from django.conf import settings

from storages.backends.s3boto3 import S3Boto3Storage


class OracleObjectStorage(S3Boto3Storage):   
    pass


class ClassifiedAdTmpImageStorage(OracleObjectStorage):
    bucket_name = settings.CLASSIFIEDAD_TMPIMG_BUCKET 
    
    
class ClassifiedAdImageStorage(OracleObjectStorage):
    bucket_name = settings.CLASSIFIEDAD_IMG_BUCKET


class StaticFilesStorage(OracleObjectStorage):
    bucket_name = settings.STATICFILES_BUCKET
    custom_domain = f'{settings.OCI_BUCKET_NAMESPACE}.compat.objectstorage.{settings.OCI_REGION}.oraclecloud.com/{settings.STATICFILES_BUCKET}'    