#
# state_city/api/serializers.py
#

from rest_framework import serializers

from state_city.models import State, StateCity


class StateSerializer(serializers.ModelSerializer):
    class Meta:
        model = State
        fields = ('id', 'state', 'acronym',)


class StateCitySerializer(serializers.ModelSerializer):
    class Meta:
        model = StateCity
        fields = ('id', 'city',)