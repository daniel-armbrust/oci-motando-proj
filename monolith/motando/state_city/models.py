#
# state_city/models.py
#

from django.db import models


class State(models.Model):
    state = models.CharField(max_length=100, null=False)
    acronym = models.CharField(max_length=2, null=False, unique=True)

    class Meta:
        db_table = 'states'

    def __str__(self):
        return '%s (%s)' % (self.state, self.acronym,)


class StateCity(models.Model):
    city = models.CharField(max_length=100, null=False)
    state = models.ForeignKey(State, on_delete=models.CASCADE, null=False,
        related_name='state_cities')

    class Meta:
        db_table = 'cities'

    def __str__(self):
        return '%s (%s - %s)' % (self.city, self.state.state, self.state.acronym,)