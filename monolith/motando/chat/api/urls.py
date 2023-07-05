#
# chat/api/urls.py
#

from django.urls import path

from . import views

app_name = 'chat'

urlpatterns = [
    path('messages', views.CreateChatView.as_view(), name='create_chat'),    
]