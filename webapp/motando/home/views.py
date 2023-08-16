#
# home/views.py
#

from django.shortcuts import render, redirect
from django.urls import reverse
from django.views import View

from classifiedad.models import ClassifiedAd


class MainPageView(View):
    def get(self, request):
        max_top_classifiedad = 15

        top_classifiedad =  ClassifiedAd.objects.filter(status='published',
                                                        top_offer=True).all().order_by('-updated')[:max_top_classifiedad]

        return render(request, 'home.html', {
            'top_classifiedad': top_classifiedad
        })
    
    def post(self, request):
        search_url = request.POST.get('search_url', None)

        if search_url:            
            next_url = reverse('classifiedad:all') + '?q=' + search_url
        else:
            next_url = reverse('classifiedad:all')
        
        return redirect(next_url)
            