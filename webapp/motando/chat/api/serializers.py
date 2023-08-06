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
    classifiedad_id = serializers.IntegerField(required=True)
    message = serializers.CharField(max_length=1000)

    def create(self, validated_data):
        try:
            classifiedad = ClassifiedAd.objects.filter(id=validated_data.get('classifiedad_id'), 
                                                       status='PUBLISHED').get()
        except ClassifiedAd.DoesNotExist:
             raise serializers.ValidationError({'status': 'fail', 'message': 'Unable to create new Chat message.'})

        new_message = {
            'from': validated_data.get('fullname_from'), 
            'text': validated_data.get('message'),
            'timestamp': datetime.now().isoformat()
        }

        user_from = User.objects.filter(email=validated_data.get('email_from'))

        if user_from.exists():
            chat = Chat.objects.filter(classifiedad=classifiedad, 
                                       user_from_email=user_from.get().email)
        else:
            chat = Chat.objects.filter(classifiedad=classifiedad, 
                                       user_from_email=validated_data.get('email_from'))   
        
        if chat.exists():
            messages = chat.get().messages
            messages.append(new_message)

            chat.update(messages=messages)
        else:
            chat = Chat(classifiedad=classifiedad, user_to=classifiedad.user,
                        user_from_fullname=validated_data.get('fullname_from'),
                        user_from_email=validated_data.get('email_from'),
                        user_from_telephone=validated_data.get('telephone_from'),
                        messages=[new_message]).save()

        return validated_data


class ChatSellingParticipantListSerializer(serializers.ModelSerializer):
    class Meta:
        model = Chat

        fields = ('id', 'user_from', 'user_from_fullname', 'user_from_email', 
                  'user_from_telephone',)


class ChatSellingMessagesListSerializer(serializers.ModelSerializer):
    class Meta:
        model = Chat

        fields = ('id', 'user_from', 'user_from_fullname', 'user_from_email', 
                  'user_from_telephone', 'messages', 'created',)
        
    def to_representation(self, instance):
        representation = super().to_representation(instance)

        try:
            model_version = instance.classifiedad.model_version.version
        except AttributeError:
            model_version = ''

        if model_version:
            representation['motorcycle'] = f'{instance.classifiedad.model.brand.brand} - {instance.classifiedad.model.model} ({model_version})'
        else:
            representation['motorcycle'] = f'{instance.classifiedad.model.brand.brand} - {instance.classifiedad.model.model}'

        representation['price'] = instance.classifiedad.price
        
        return representation
        

class ChatMessagesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Chat
        fields = '__all__'

    def to_representation(self, instance):
        representation = super().to_representation(instance)

        try:
            model_version = instance.classifiedad.model_version.version
        except AttributeError:
            model_version = ''

        if model_version:
            representation['motorcycle'] = f'{instance.classifiedad.model.brand.brand} - {instance.classifiedad.model.model} ({model_version})'
        else:
            representation['motorcycle'] = f'{instance.classifiedad.model.brand.brand} - {instance.classifiedad.model.model}'

        representation['price'] = instance.classifiedad.price
        
        return representation