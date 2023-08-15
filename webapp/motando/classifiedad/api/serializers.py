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
        
        fields = ('id', 'fabrication_year', 'model_year', 'sales_phrase',
                  'mileage', 'is_new', 'color', 'price', 'images', 
                  'doc_ok', 'accept_exchange', 'accept_new_offer',)
    
    def to_representation(self, instance):
        representation = super().to_representation(instance)

        representation['brand'] = instance.model.brand.brand
        representation['model'] = instance.model.model

        try:
            representation['model_version'] = instance.model_version.version        
        except AttributeError:
            representation['model_version'] = ""        

        return representation