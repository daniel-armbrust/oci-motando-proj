#
# state_city/api/views.py
#

from rest_framework import views, status
from rest_framework.response import Response

from state_city.models import State, StateCity
from state_city.api.serializers import StateSerializer, StateCitySerializer


class BrazilStateListApiView(views.APIView):
    def get(self, request):
        state = State.objects.all()

        if not state.exists():
            return Response(
                data={'status' : 'fail', 'message' :'No Motorcycle Brand Model found.'}, 
                status=status.HTTP_404_NOT_FOUND
            ) 
        
        serializer = StateSerializer(state, many=True)

        return Response(
            data={'status' : 'success', 'data': serializer.data},
            status=status.HTTP_200_OK
        )


class BrazilStateApiView(views.APIView):
    def get(self, request, state_id):
        try:
            state = State.objects.get(id=state_id)
        except State.DoesNotExist:
            return Response(
                data={'status' : 'fail', 'message' :'No Brazil State found.'}, 
                status=status.HTTP_404_NOT_FOUND
            )
        
        serializer = StateSerializer(state)

        return Response(
            data={'status' : 'success', 'data': serializer.data},
            status=status.HTTP_200_OK
        )


class BrazilStateCityListApiView(views.APIView):
    def get(self, request, state_id):
        state_city = StateCity.objects.filter(state__id=state_id)

        if not state_city.exists():
            return Response(
                data={'status' : 'fail', 'message' :'No Brazil State City found.'}, 
                status=status.HTTP_404_NOT_FOUND
            )
        
        serializer = StateCitySerializer(state_city, many=True)

        return Response(
            data={'status' : 'success', 'data': serializer.data},
            status=status.HTTP_200_OK
        )


class BrazilStateCityApiView(views.APIView):
    def get(self, request, state_id, city_id):
        try:
            state_city = StateCity.objects.get(state__id=state_id, id=city_id)
        except StateCity.DoesNotExist:
            return Response(
                data={'status' : 'fail', 'message' :'No Brazil State City found.'}, 
                status=status.HTTP_404_NOT_FOUND
            )
        
        serializer = StateCitySerializer(state_city)

        return Response(
            data={'status' : 'success', 'data': serializer.data},
            status=status.HTTP_200_OK
        )