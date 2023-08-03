#
# state_city/api/urls.py
#

from django.urls import path

from . import views

app_name = 'state_city'

urlpatterns = [
    path('states', views.BrazilStateListApiView.as_view(), name='state_list'),
    path('states/<int:state_id>', views.BrazilStateApiView.as_view(), name='state'),
    path('states/<int:state_id>/cities', views.BrazilStateCityListApiView.as_view(), name='state_city_list'),
    path('states/<int:state_id>/cities/<int:city_id>', views.BrazilStateCityApiView.as_view(), name='state_city')
]

