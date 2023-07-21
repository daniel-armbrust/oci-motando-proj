#
# account/urls.py
#

from django.urls import path
from django.views.generic.base import TemplateView
from django.contrib.auth.decorators import login_required

from . import views

app_name = 'account'

urlpatterns = [
    path('login', views.user_login, name='login'),
    path('logout', login_required(views.user_logout), name='logout'),

    path('registro', TemplateView.as_view(template_name='account/choices.html'), name='choices'),
    path('new/user', views.NewUserView.as_view(), name='new_user'),
    path('new/user/success', TemplateView.as_view(template_name='account/confirmation.html'), 
         name='new_user_success'),

    path('user/home', login_required(views.UserProfileHomeView.as_view()), name='home'),
    path('user/profile', login_required(views.UserProfileView.as_view()), name='profile'),
    path('user/password_and_security', login_required(views.UserPasswordSecurityView.as_view()), name='password_security'),
]