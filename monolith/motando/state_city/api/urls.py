#
# state_city/api/urls.py
#

from django.urls import path

from . import views

app_name = 'state_city'

urlpatterns = [
    path('states', views.StateListView.as_view(), name='state_list'),
    path('states/<int:pk>', views.StateDetailView.as_view(), name='state_detail'),
    path('states/<int:state_id>/cities', views.StateCityListView.as_view(), name='state-city_list'),
    path('states/<int:state_id>/cities/<int:city_id>', views.StateCityDetailView.as_view(), name='state-city_detail')
]