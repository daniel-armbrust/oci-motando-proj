#
# home/views.py
#

from django.shortcuts import render
from django.views import View


class MainPageView(View):
    def get(self, request):
        return render(request, 'desktop_home.html', {})
 

