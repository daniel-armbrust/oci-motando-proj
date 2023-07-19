#
# chat/api/views.py
#

from rest_framework import views,  status
from rest_framework.response import Response

from chat.api.serializers import NewChatSerializer, ChatMessagesSerializer
from chat.models import Chat


class ChatApiView(views.APIView):   
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
                             'data':[serializer.errors]}, status=status.HTTP_400_BAD_REQUEST)
      
    def delete(self, request, chat_id):
        pass


class ChatBuyingApiView(views.APIView):
    def get(self, request, user_id):
        try:
            chat = Chat.objects.get(user_from__id=user_id)
        except Chat.DoesNotExist:
            return Response(data={'status': 'fail', 'message': 'No Chat Message(s) found.'},
                            status=status.HTTP_404_NOT_FOUND)

        serializer = ChatMessagesSerializer(chat)

        return Response(data={'status' : 'success', 'data': [serializer.data]},
                        status=status.HTTP_200_OK)
                

class ChatSellingApiView(views.APIView):
    def get(self, request, user_id):
        try:
            chat = Chat.objects.get(user_to__id=user_id)
        except Chat.DoesNotExist:
            return Response(data={'status': 'fail', 'message': 'No Chat Message(s) found.'},
                            status=status.HTTP_404_NOT_FOUND)

        serializer = ChatMessagesSerializer(chat)

        return Response(data={'status' : 'success', 'data': [serializer.data]},
                        status=status.HTTP_200_OK)
           
        