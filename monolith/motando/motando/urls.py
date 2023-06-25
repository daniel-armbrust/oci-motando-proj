"""
URL configuration for motando project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.urls import path, include

urlpatterns = [
    # Admin Site
    path('motandoadm/', include('motandoadm.urls', namespace='motandoadm')),

    path('', include('home.urls', namespace='home')),
    path('conta/', include('account.urls', namespace='account')),

    path('anuncio/', include('classifiedad.urls', namespace='classifiedad')),

    # API
    path('api/brasil/', include('state_city.api.urls', namespace='api_state-city')),
    path('api/moto/', include('motorcycle.api.urls', namespace='api_motorcycle')),
]
