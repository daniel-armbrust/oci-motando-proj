#
# chat/api/views.py
#

from rest_framework import views,  status
from rest_framework.response import Response
from rest_framework.authentication import SessionAuthentication
from rest_framework.permissions import IsAuthenticated

from chat.api.serializers import NewChatSerializer, \
    ChatSellingParticipantListSerializer, ChatSellingMessagesListSerializer, \
    ChatBuyingParticipantListSerializer, ChatBuyingMessagesListSerializer

from chat.models import Chat


class CsrfExemptSessionAuthentication(SessionAuthentication):
    def enforce_csrf(self, request):
        return  # To not perform the csrf check previously happening


class ChatApiView(views.APIView):    
    authentication_classes = (CsrfExemptSessionAuthentication,)

    def post(self, request):
        if request.data.get('email_from') ==  request.data.get('email_to'):
            return Response({'status': 'fail', 'message': 'Unable to create new Chat message.'},
                            status=status.HTTP_400_BAD_REQUEST) 
      
        serializer = NewChatSerializer(data=request.data)
       
        if serializer.is_valid():
            serializer.save()

            return Response({'status': 'success', 'message': 'The message was successful send.'},
                            status=status.HTTP_200_OK) 
        
        else:        
            return Response({'status' : 'fail', 'message' : 'Unable to process new Chat message.', 
                             'data': serializer.errors}, status=status.HTTP_400_BAD_REQUEST)     
    

class ChatBuyingParticipantsListApiView(views.APIView):
    #authentication_classes = (SessionAuthentication,)
    #permission_classes = (IsAuthenticated,)

    def get(self, request):        
        chat = Chat.objects.filter(user_from_email=request.user.email,                                                          
                                   classifiedad__status='PUBLISHED')
        
        if not chat.exists():
            return Response(data={'status': 'fail', 'message': 'No Chat Message(s) found.'},
                            status=status.HTTP_404_NOT_FOUND)
        
        serializer = ChatBuyingParticipantListSerializer(chat, many=True)

        return Response(data={'status' : 'success', 'data': serializer.data},
                        status=status.HTTP_200_OK)


class ChatBuyingMessagesListApiView(views.APIView):
    #authentication_classes = (SessionAuthentication,)
    #permission_classes = (IsAuthenticated,)

    def get(self, request, chat_id):
        chat = Chat.objects.filter(id=chat_id, 
                                   user_from_email=request.user.email,                                                    
                                   classifiedad__status='PUBLISHED')
        
        if not chat.exists():
            return Response(data={'status': 'fail', 'message': 'No Chat Message(s) found.'},
                            status=status.HTTP_404_NOT_FOUND)
        
        serializer = ChatBuyingMessagesListSerializer(chat, many=True)

        return Response(data={'status' : 'success', 'data': serializer.data},
                        status=status.HTTP_200_OK)


class ChatSellingParticipantsListApiView(views.APIView):
    authentication_classes = (SessionAuthentication,)
    permission_classes = (IsAuthenticated,)

    def get(self, request):
        chat = Chat.objects.filter(user_to__id=request.user.id,                
                                   user_to__is_active=True,        
                                   classifiedad__status='PUBLISHED')
        
        if not chat.exists():
            return Response(data={'status': 'fail', 'message': 'No Chat Message(s) found.'},
                            status=status.HTTP_404_NOT_FOUND)
        
        serializer = ChatSellingParticipantListSerializer(chat, many=True)

        return Response(data={'status' : 'success', 'data': serializer.data},
                        status=status.HTTP_200_OK)
     

class ChatSellingMessagesListApiView(views.APIView):
    authentication_classes = (SessionAuthentication,)
    permission_classes = (IsAuthenticated,)

    def get(self, request, chat_id):
        chat = Chat.objects.filter(id=chat_id,
                                   user_to__id=request.user.id,                
                                   user_to__is_active=True,        
                                   classifiedad__status='PUBLISHED')
        
        if not chat.exists():
            return Response(data={'status': 'fail', 'message': 'No Chat Message(s) found.'},
                            status=status.HTTP_404_NOT_FOUND)
        

        serializer = ChatSellingMessagesListSerializer(chat, many=True)

        return Response(data={'status' : 'success', 'data': serializer.data},
                        status=status.HTTP_200_OK)