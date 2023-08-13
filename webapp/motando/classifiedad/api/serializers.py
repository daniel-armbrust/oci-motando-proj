#
# classifiedad/api/serializers.py
#

from rest_framework import serializers

from classifiedad.models import ClassifiedAd, ClassifiedAdImage


class ClassifiedAdImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = ClassifiedAdImage
        fields = ('url',)


class ClassifiedAdSerializer(serializers.ModelSerializer):   
    images = ClassifiedAdImageSerializer(many=True, read_only=True)   
  
    class Meta:
        model = ClassifiedAd                
        exclude = ('user', 'status', 'license_plate',)
    
    def to_representation(self, instance):
        representation = super().to_representation(instance)

        representation['brand'] = instance.model.brand.brand
        representation['model'] = instance.model.model

        try:
            representation['model_version'] = instance.model_version.version        
        except AttributeError:
            representation['model_version'] = ""        

        return representation