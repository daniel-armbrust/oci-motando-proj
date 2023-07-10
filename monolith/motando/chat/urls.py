#
# chat/urls.py
#

from django.urls import path
from django.contrib.auth.decorators import login_required

from . import views

app_name = 'chat'

urlpatterns = [    
    path('home', login_required(views.ChatHomeView.as_view()), name='home'),    
]