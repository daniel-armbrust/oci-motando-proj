#
# chat/api/serializers.py
#

from datetime import datetime

from rest_framework import serializers

from account.models import User
from chat.models import Chat
from classifiedad.models import ClassifiedAd


class NewChatSerializer(serializers.Serializer):
    fullname_from = serializers.CharField(required=True, allow_blank=False, max_length=200)
    email_from = serializers.EmailField(required=True, allow_blank=False)
    telephone_from = serializers.CharField(required=True, allow_blank=False, max_length=40)
    email_to = serializers.EmailField(required=True, allow_blank=False)
    classifiedad_id = serializers.IntegerField(required=True)
    message = serializers.CharField(max_length=1000)

    def create(self, validated_data):
        classifiedad = ClassifiedAd.objects.filter(id=validated_data.get('classifiedad_id'))
        user_to = User.objects.filter(email=validated_data.get('email_to'))
        
        if not classifiedad.exists() or not user_to.exists():
            raise serializers.ValidationError({'status': 'fail', 'message': 'Unable to create new Chat message.'})
       
        new_message = {
            'from': validated_data.get('email_from'), 
            'text': validated_data.get('message'),
            'timestamp': datetime.now().isoformat()
        }

        user_from = User.objects.filter(email=validated_data.get('email_from'))
       
        if user_from.exists():            
            chat = Chat.objects.filter(classifiedad=classifiedad.get(), user_from=user_from.get())

            if chat.exists():
                messages = chat.get().messages
                messages.append(new_message)

                chat.update(messages=messages)

            else:                           
                chat = Chat(classifiedad=classifiedad, user_to=user_to, user_from=user_from,
                            messages=[new_message]).save()
        else:          
            chat = Chat.objects.filter(classifiedad=classifiedad.get(), 
                                       user_from_email=validated_data.get('email_from'))
            if chat.exists():
                messages = chat.get().messages
                messages.append(new_message)

                chat.update(messages=messages)

            else:
                chat = Chat(classifiedad=classifiedad.get(), user_to=user_to.get(), 
                            user_from_fullname=validated_data.get('fullname_from'),
                            user_from_email=validated_data.get('email_from'),
                            user_from_telephone=validated_data.get('telephone_from'),
                            messages=[new_message]).save()
            
        return validated_data    