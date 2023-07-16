#
# classifiedad/api/view.py
#

from rest_framework import generics

from classifiedad.models import ClassifiedAd
from classifiedad.api.serializers import ClassifiedAdSerializer


class ClassifiedAdReadApiView(generics.ListAPIView):    
    serializer_class = ClassifiedAdSerializer

    def get_queryset(self):
        classifiedad_id = self.kwargs['classifiedad_id']

        return ClassifiedAd.objects.filter(id=classifiedad_id)