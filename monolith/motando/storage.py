#
# motando/storage.py
#

#from datetime import datetime, timedelta
#from urllib.parse import urlencode

from django.conf import settings
#from django.utils.encoding import filepath_to_uri

from storages.backends.s3boto3 import S3Boto3Storage


class OracleObjectStorage(S3Boto3Storage):   
    pass


class ClassifiedAdTmpImageStorage(OracleObjectStorage):
    bucket_name = settings.CLASSIFIEDAD_TMPIMG_BUCKET 
    
    
class ClassifiedAdImageStorage(OracleObjectStorage):
    bucket_name = settings.CLASSIFIEDAD_IMG_BUCKET
        