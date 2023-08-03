#
# motorcycle/api/views.py
#

from rest_framework import views, status
from rest_framework.response import Response

from motorcycle.models import MotorcycleBrand, MotorcycleBrandModel, MotorcycleBrandModelVersion
from motorcycle.api.serializers import MotorcycleBrandSerializer, MotorcycleBrandModelSerializer, MotorcycleBrandModelVersionSerializer


class MotorcycleBrandListApiView(views.APIView):
    def get(self, request):
        motorcycle_brand = MotorcycleBrand.objects.all()

        if not motorcycle_brand.exists():
            return Response(
                data={'status' : 'fail', 'message' :'No Motorcycle Brand found.'}, 
                status=status.HTTP_404_NOT_FOUND
            ) 

        serializer = MotorcycleBrandSerializer(motorcycle_brand, many=True)
        
        return Response(
            data={'status' : 'success', 'data': serializer.data},
            status=status.HTTP_200_OK
        )


class MotorcycleBrandApiView(views.APIView):
    def get(self, request, brand_id):
        try:
            motorcycle_brand = MotorcycleBrand.objects.get(id=brand_id)
        except MotorcycleBrand.DoesNotExist:
            return Response(
                data={'status' : 'fail', 'message' :'No Motorcycle Brand found.'}, 
                status=status.HTTP_404_NOT_FOUND
            )   

        serializer = MotorcycleBrandSerializer(motorcycle_brand)

        return Response(
            data={'status' : 'success', 'data': serializer.data},
            status=status.HTTP_200_OK
        )
    

class MotorcycleBrandModelListApiView(views.APIView):
    def get(self, request, brand_id):
        motorcycle_brand_model = MotorcycleBrandModel.objects.filter(brand__id=brand_id)
        
        if not motorcycle_brand_model.exists():
            return Response(
                data={'status' : 'fail', 'message' :'No Motorcycle Brand Model found.'}, 
                status=status.HTTP_404_NOT_FOUND
            )   
        
        serializer = MotorcycleBrandModelSerializer(motorcycle_brand_model, many=True)

        return Response(
            data={'status' : 'success', 'data': serializer.data},
            status=status.HTTP_200_OK
        )


class MotorcycleBrandModelApiView(views.APIView):
    def get(self, request, brand_id, model_id):
        try:
            motorcycle_brand_model = MotorcycleBrandModel.objects.get(brand__id=brand_id, id=model_id)
        except MotorcycleBrandModel.DoesNotExist:
            return Response(
                data={'status' : 'fail', 'message' :'No Motorcycle Brand Model found.'}, 
                status=status.HTTP_404_NOT_FOUND
            )
    
        serializer = MotorcycleBrandModelSerializer(motorcycle_brand_model)

        return Response(
            data={'status' : 'success', 'data': serializer.data},
            status=status.HTTP_200_OK
        )


class MotorcycleBrandModelVersionListApiView(views.APIView):
    def get(self, request, brand_id, model_id):
        motorcycle_brand_model_version = MotorcycleBrandModelVersion.objects.filter(model__id=model_id, 
                                                                                    model__brand__id=brand_id)
                                                                                            
        if not motorcycle_brand_model_version.exists():
            return Response(
                data={'status' : 'fail', 'message' :'No Motorcycle Brand Model found.'}, 
                status=status.HTTP_404_NOT_FOUND
            )   
        
        serializer = MotorcycleBrandModelVersionSerializer(motorcycle_brand_model_version, many=True)

        return Response(
            data={'status' : 'success', 'data': serializer.data},
            status=status.HTTP_200_OK
        )


class MotorcycleBrandModelVersionApiView(views.APIView):
    def get(self, request, brand_id, model_id, version_id):
        try:
            motorcycle_brand_model_version = MotorcycleBrandModelVersion.objects.get(model__id=model_id,
                                                                                     model__brand__id=brand_id,
                                                                                     id=version_id)
        except MotorcycleBrandModelVersion.DoesNotExist:
            return Response(
                data={'status' : 'fail', 'message' :'No Motorcycle Brand Model Version found.'}, 
                status=status.HTTP_404_NOT_FOUND
            ) 
        
        serializer = MotorcycleBrandModelVersionSerializer(motorcycle_brand_model_version)

        return Response(
            data={'status' : 'success', 'data': serializer.data},
            status=status.HTTP_200_OK
        )