#
# state_city/api/urls.py
#

from django.urls import path

from . import views

app_name = 'state_city'

urlpatterns = [
    path('estado', views.StateListView.as_view(), name='state_list'),
    path('estado/<int:pk>', views.StateDetailView.as_view(), name='state_detail'),
    path('estado/<int:state_id>/cidade', views.StateCityListView.as_view(), name='state-city_list'),
    path('estado/<int:state_id>/cidade/<int:city_id>', views.StateCityDetailView.as_view(), name='state-city_detail')
]