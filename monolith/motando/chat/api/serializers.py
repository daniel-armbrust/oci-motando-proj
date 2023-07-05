#
# chat/api/serializers.py
#

from datetime import datetime

from rest_framework import serializers


class Chat:
    def __init__(self, user_from_id: int, user_from_fullname: str, user_to_id: int, 
                 user_to_fullname: str, classifiedad_id: int, message: str):
         user_from_id = user_from_id
         user_from_fullname = user_from_fullname    
         user_to_id = user_to_id
         user_to_fullname = user_to_fullname
         classifiedad_id = classifiedad_id
         message = message
         created = datetime.now()

class ChatSerializer(serializers.Serializer):
     user_from_id = serializers.IntegerField()
     user_from_fullname = serializers.CharField(max_length=500)
     user_to_id = serializers.IntegerField()
     user_to_fullname = serializers.CharField(max_length=500)
     classifiedad_id = serializers.IntegerField()
     message = serializers.CharField(max_length=1000)