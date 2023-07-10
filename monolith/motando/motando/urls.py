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
from django.urls import path, include, re_path
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView, TokenVerifyView

urlpatterns = [
    # Admin Site
    path('motandoadm/', include('motandoadm.urls', namespace='motandoadm')),

    path('', include('home.urls', namespace='home')),
    path('account/', include('account.urls', namespace='account')),
    path('classifiedad/', include('classifiedad.urls', namespace='classifiedad')),
    path('chat/', include('chat.urls', namespace='chat')),

    # API Token
    re_path(r'^api/token/$', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    re_path(r'^api/token/refresh/$', TokenRefreshView.as_view(), name='token_refresh'),
    re_path(r'^api/token/verify/$', TokenVerifyView.as_view(), name='token_verify'),

    # API
    path('api/brasil/', include('state_city.api.urls', namespace='api_state-city')),
    path('api/motorcycles/', include('motorcycle.api.urls', namespace='api_motorcycles')),
    path('api/chats/', include('chat.api.urls', namespace='api_chats')),
]
