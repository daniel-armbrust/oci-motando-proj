#
# chat/api/urls.py
#

from django.urls import path

from . import views

app_name = 'chat'

urlpatterns = [
    # Public endpoint.
    path('messages', views.ChatApiView.as_view(), name='messages'),    

    # Private endpoint (needs authentication).
    path('users/messages/buying/participants', 
         views.ChatBuyingParticipantListApiView.as_view(), name='buying_participant_list'),    

    path('users/messages/buying/participants/<int:participant_id>',
         views.ChatBuyingParticipantIdApiView.as_view(), name='buying_participant_id'),    

    path('messages/selling/participants', 
         views.ChatSellingParticipantListApiView.as_view(), name='selling_participant_list'),  

    path('<int:chat_id>/messages/selling', 
         views.ChatSellingMessagesListApiView.as_view(), name='selling_messages_list'),    
]