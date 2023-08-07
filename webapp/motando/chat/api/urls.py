#
# chat/api/urls.py
#

from django.urls import path

from . import views

app_name = 'chat'

urlpatterns = [
    # Public endpoint.
    path('messages', views.PublicChatMessageApiView.as_view(), name='public_message'),    

    # Private endpoint (needs authentication).
    path('messages/buying/participants', 
         views.ChatBuyingParticipantsListApiView.as_view(), name='buying_participant_list'),    

    path('<int:chat_id>/messages/buying',
         views.ChatBuyingMessagesListApiView.as_view(), name='buying_participant_id'),    

    path('messages/selling/participants', 
         views.ChatSellingParticipantsListApiView.as_view(), name='selling_participant_list'),  

    path('<int:chat_id>/messages/selling', 
         views.ChatSellingMessagesListApiView.as_view(), name='selling_messages_list'),   

    path('<int:chat_id>/messages', views.ChatMessageApiView.as_view(), name='message'),
]