#
# classifiedad/api/view.py
#

import logging as log

from rest_framework import views, status
from rest_framework.response import Response

from classifiedad.models import ClassifiedAd
from classifiedad.api.serializers import ClassifiedAdSerializer


class ClassifiedAdApiView(views.APIView):
    def get(self, request, classifiedad_id, format=None):
        try:
            classifiedad = ClassifiedAd.objects.get(id=classifiedad_id)
        except ClassifiedAd.DoesNotExist:
            return Response(
                data={'status' : 'fail', 'message' :'No ClassifiedAd found.'}, 
                status=status.HTTP_404_NOT_FOUND
            )      

        serializer = ClassifiedAdSerializer(classifiedad)              

        return Response(
            data={'status' : 'success', 'data': [serializer.data]},
            status=status.HTTP_200_OK
        )

