#
# classifiedad/api/urls.py
#

from django.urls import path

from . import views

app_name = 'classifiedad'

urlpatterns = [
    path('<int:classifiedad_id>', views.ClassifiedAdApiView.as_view(), name='classifiedad_read'),   
]