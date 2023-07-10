#
# home/views.py
#

from django.shortcuts import render, get_object_or_404
from django.views import View

from account.models import UserProfile



class ChatHomeView(View):
    def get(self, request):
        user_profile = get_object_or_404(UserProfile, user=request.user)

        return render(request, 'chat/home.html', {'user_profile': user_profile})
 

