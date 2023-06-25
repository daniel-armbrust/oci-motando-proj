#
# state_city/api/views.py
#

from rest_framework import generics, exceptions

from state_city.models import State, StateCity
from state_city.api.serializers import StateSerializer, StateCitySerializer


class StateListView(generics.ListAPIView):
    queryset = State.objects.all()
    serializer_class = StateSerializer


class StateDetailView(generics.RetrieveAPIView):
    queryset = State.objects.all()
    serializer_class = StateSerializer
        

class StateCityListView(generics.ListAPIView):
    queryset = StateCity.objects.all()
    serializer_class = StateCitySerializer

    def get_queryset(self):
        state_id = self.kwargs.get('state_id', None)
        
        cities = StateCity.objects.filter(state__id=state_id)

        if len(cities) > 0:
            return cities
        else:
            raise exceptions.NotFound()


class StateCityDetailView(generics.RetrieveAPIView):
    queryset = StateCity.objects.all()
    serializer_class = StateCitySerializer

    def get_object(self):
        state_id = self.kwargs.get('state_id', None)
        city_id = self.kwargs.get('city_id', None)

        try:
            city = StateCity.objects.get(state__id=state_id, id=city_id)
        except StateCity.DoesNotExist:
            raise exceptions.NotFound
        
        return city