#
# classifiedad/api/view.py
#

from rest_framework import generics
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.pagination import PageNumberPagination

from classifiedad.models import ClassifiedAd
from classifiedad.api.serializers import ClassifiedAdSerializer


class ClassifiedAdListApiView(generics.ListAPIView):
    queryset = ClassifiedAd.objects.filter(status='published').all()
    serializer_class = ClassifiedAdSerializer
    filter_backends = [DjangoFilterBackend]        

    filterset_fields = [
        'model__brand', 
        'model', 
        'user__user__state', 
        'user__user__city',
        'color',
        'is_new',
        'doc_ok',
        'brake_system',
        'ignition_system',
        'accept_new_offer',
        'accept_exchange',
        'optional_gps',
        'optional_alarm',
        'optional_chest',
        'optional_computer'
    ]