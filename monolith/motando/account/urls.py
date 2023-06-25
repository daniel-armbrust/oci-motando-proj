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

    path('registro', TemplateView.as_view(template_name='account/register/choices.html'), name='choices'),
    path('novo/usuario', views.NewUserView.as_view(), name='new_user'),
    path('novo/usuario/sucesso', TemplateView.as_view(template_name='account/register/confirmation.html'), 
         name='new_user_success'),

    path('usuario/home', login_required(views.UserProfileHomeView.as_view()), name='home'),
    path('usuario/perfil', login_required(views.UserProfileView.as_view()), name='profile'),
]