#
# classifiedad/api/view.py
#

from rest_framework import generics
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.pagination import PageNumberPagination

from classifiedad.models import ClassifiedAd
from classifiedad.api.serializers import ClassifiedAdSerializer


class ClassifiedAdPagination(PageNumberPagination):
    page_size = 7
    page_size_query_param = 'page_size'
    

class ClassifiedAdListApiView(generics.ListAPIView):
    queryset = ClassifiedAd.objects.filter(status='published').all()
    serializer_class = ClassifiedAdSerializer
    pagination_class = ClassifiedAdPagination
    filter_backends = [DjangoFilterBackend]  

    filterset_fields = [
        'model__brand__brand',       
        'model__model', 
        'user__user__state', 
        'user__user__city',
        'brake_system',
        'ignition_system',
        'color',
        'is_new',
        'doc_ok', 
        'accept_exchange',       
        'accept_new_offer'        
    ]