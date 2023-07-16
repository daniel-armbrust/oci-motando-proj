#
# classifiedad/api/serializers.py
#

from rest_framework import serializers

from classifiedad.models import ClassifiedAd, ClassifiedAdImage
from motorcycle.models import MotorcycleBrand, MotorcycleBrandModel


class ClassifiedAdImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = ClassifiedAdImage
        fields = ('url',)


class ClassifiedAdSerializer(serializers.ModelSerializer):   
    images = ClassifiedAdImageSerializer(many=True, read_only=True)   
  
    class Meta:
        model = ClassifiedAd                
        exclude = ('user',)
    
    def to_representation(self, instance):
        representation = super().to_representation(instance)

        representation['brand'] = instance.model.brand.brand
        representation['model'] = instance.model.model
        representation['model_version'] = instance.model_version.version        
        representation['user_email'] = instance.user.email
        representation['user_telephone'] = instance.user.user.telephone   

        return representation