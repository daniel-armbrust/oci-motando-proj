#
# home/urls.py
#

from django.urls import path

from . import views

app_name = 'home'

urlpatterns = [
    path('', views.MainPageView.as_view(), name='main_page'),         
]