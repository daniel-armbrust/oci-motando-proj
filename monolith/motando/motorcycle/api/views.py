#
# motorcycle/api/views.py
#

from rest_framework import generics, exceptions

from motorcycle.models import MotorcycleBrand, MotorcycleBrandModel, MotorcycleBrandModelVersion
from motorcycle.api.serializers import MotorcycleBrandSerializer, MotorcycleBrandModelSerializer, MotorcycleBrandModelVersionSerializer


class MotorcycleBrandListView(generics.ListAPIView):
    queryset = MotorcycleBrand.objects.all()
    serializer_class = MotorcycleBrandSerializer


class MotorcycleBrandDetailView(generics.RetrieveAPIView):
    queryset = MotorcycleBrand.objects.all()
    serializer_class = MotorcycleBrandSerializer


class MotorcycleBrandModelListView(generics.ListAPIView):
    queryset = MotorcycleBrandModel.objects.all()
    serializer_class = MotorcycleBrandModelSerializer

    def get_queryset(self):
        brand_id = self.kwargs.get('brand_id', None)

        brands = MotorcycleBrandModel.objects.filter(brand__id=brand_id)

        if len(brands):
            return brands
        else:
            raise exceptions.NotFound()


class MotorcycleBrandModelDetailView(generics.RetrieveAPIView):
    queryset = MotorcycleBrandModel.objects.all()
    serializer_class = MotorcycleBrandModelSerializer

    def get_object(self):
        brand_id = self.kwargs.get('brand_id', None)
        model_id = self.kwargs.get('model_id', None)

        try:
            modelo = MotorcycleBrandModel.objects.get(brand__id=brand_id, id=model_id)
        except MotorcycleBrandModel.DoesNotExist:
            raise exceptions.NotFound()
        
        return modelo


class MotorcycleModelVersionListView(generics.ListAPIView):
    queryset = MotorcycleBrandModelVersion.objects.all()
    serializer_class = MotorcycleBrandModelVersionSerializer

    def get_queryset(self):
        brand_id = self.kwargs.get('brand_id', None)
        model_id = self.kwargs.get('model_id', None)

        versions = MotorcycleBrandModelVersion.objects.filter(model__brand__id=brand_id, model__id=model_id)

        if len(versions) > 0:
            return versions
        else:
            raise exceptions.NotFound()


class MotorcycleModelVersionDetailView(generics.RetrieveAPIView):
    queryset = MotorcycleBrandModelVersion.objects.all()
    serializer_class = MotorcycleBrandModelVersionSerializer

    def get_object(self):
        brand_id = self.kwargs.get('brand_id', None)
        model_id = self.kwargs.get('model_id', None)
        version_id = self.kwargs.get('version_id', None)

        try:
            version = MotorcycleBrandModelVersion.objects.get(model__brand__id=brand_id, 
                model__id=model_id, id=version_id)
        except MotorcycleBrandModelVersion.DoesNotExist:
            raise exceptions.NotFound()
        
        return version