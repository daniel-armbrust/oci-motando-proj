#
# chat/api/urls.py
#

from django.urls import path

from . import views

app_name = 'chat'

urlpatterns = [
    path('messages', views.ChatApiView.as_view(), name='messages'),    
    path('users/<int:user_id>/messages/buying', views.ChatBuyingApiView.as_view(), name='buying'),    
    path('users/<int:user_id>/messages/selling', views.ChatSellingApiView.as_view(), name='selling'),    
]