#
# chat/api/views.py
#

from rest_framework import views,  status
from rest_framework.response import Response
from rest_framework.authentication import SessionAuthentication
from rest_framework.permissions import IsAuthenticated

from chat.api.serializers import NewChatSerializer, ChatMessagesSerializer
from chat.models import Chat


class ChatApiView(views.APIView):   
    def post(self, request):
        #if request.data.get('email_from') ==  request.data.get('email_to'):
        #    return Response({'status': 'fail', 'message': 'Unable to create new Chat message.'},
        #                    status=status.HTTP_400_BAD_REQUEST) 
      
        serializer = NewChatSerializer(data=request.data)
       
        if serializer.is_valid():
            serializer.save()

            return Response({'status': 'success', 'message': 'The message was successful send.'},
                            status=status.HTTP_200_OK) 
        
        else:        
            return Response({'status' : 'fail', 'message' : 'Unable to process new Chat message.', 
                             'data': serializer.errors}, status=status.HTTP_400_BAD_REQUEST)
      
    def delete(self, request, chat_id):
        pass


class ChatBuyingApiView(views.APIView):
    authentication_classes = [SessionAuthentication]
    permission_classes = [IsAuthenticated]

    def get(self, request, user_id):        
        if request.user.id != user_id:
            return Response(data={'status': 'fail', 'message': 'You cannot view messages that are not yours.'},
                            status=status.HTTP_403_FORBIDDEN)        
        try:
            chat = Chat.objects.get(user_from__id=user_id, 
                                    user_from__is_active=True,
                                    classifiedad__status='PUBLISHED')
        except Chat.DoesNotExist:
            return Response(data={'status': 'fail', 'message': 'No Chat Message(s) found.'},
                            status=status.HTTP_404_NOT_FOUND)

        serializer = ChatMessagesSerializer(chat)

        return Response(data={'status' : 'success', 'data': serializer.data},
                        status=status.HTTP_200_OK)
                

class ChatSellingApiView(views.APIView):
    authentication_classes = [SessionAuthentication]
    permission_classes = [IsAuthenticated]

    def get(self, request, user_id):
        if request.user.id != user_id:
            return Response(data={'status': 'fail', 'message': 'You cannot view messages that are not yours.'},
                            status=status.HTTP_403_FORBIDDEN)        
        
        chat = Chat.objects.filter(user_to__id=user_id, user_to__is_active=True)

        if not chat.exists():
            return Response(data={'status': 'fail', 'message': 'No Chat Message(s) found.'},
                            status=status.HTTP_404_NOT_FOUND)
        
        serializer = ChatMessagesSerializer(chat, many=True)

        return Response(data={'status' : 'success', 'data': serializer.data},
                        status=status.HTTP_200_OK)
           
        