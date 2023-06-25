#
# home/views.py
#

from django.shortcuts import render
from django.views import View

from classifiedad.models import ClassifiedAd


class MainPageView(View):
    def get(self, request):
        return render(request, 'desktop_home.html', {})
    

