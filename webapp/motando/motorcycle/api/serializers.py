#
# motorcycle/api/serializers.py
#

from rest_framework import serializers

from motorcycle.models import MotorcycleBrand, MotorcycleBrandModel, MotorcycleBrandModelVersion


class MotorcycleBrandSerializer(serializers.ModelSerializer):
    class Meta:
        model = MotorcycleBrand
        fields = ('id', 'brand', 'popular',)


class MotorcycleBrandModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = MotorcycleBrandModel
        fields = ('id', 'model',)    
      

class MotorcycleBrandModelVersionSerializer(serializers.ModelSerializer):
     class Meta:
        model = MotorcycleBrandModelVersion
        fields = ('id', 'version', 'model',)
