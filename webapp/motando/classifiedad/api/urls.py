#
# classifiedad/api/urls.py
#

from django.urls import path

from . import views

app_name = 'classifiedad'

urlpatterns = [   
    path('all', views.ClassifiedAdListApiView.as_view(), name='all'),   
]