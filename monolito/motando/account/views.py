#
# account/views.py
#

from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.views import View

from .models import UserProfile
from .forms import LoginForm, UserRegistrationForm, UserProfileForm


def user_login(request):
    if request.method == 'POST':
        form = LoginForm(request.POST)

        if form.is_valid():
            cleaned_data = form.cleaned_data

            user = authenticate(request, email=cleaned_data['email'],
                password=cleaned_data['password'])
            
            if (user is not None) and (user.is_active and user.is_superuser):
                login(request, user)
                return redirect('motandoadm:home')
            elif (user is not None) and user.is_active:
                login(request, user)
                return redirect('account:home')
            
        messages.error(request, 'E-mail ou Senha inválido(s)!')

    else:
        form = LoginForm()

    return render(request, 'account/login.html', {'form': form})


def user_logout(request):
    logout(request)

    return redirect('home:main_page')


class NewUserView(View):
    def get(self, request):
        user_form = UserRegistrationForm()
        user_profile_form = UserProfileForm()

        return render(request, 'account/register/form_new_user.html', {'user_form': user_form,
            'user_profile_form': user_profile_form})

    def post(self, request):
        user_form = UserRegistrationForm(request.POST or None)
        user_profile_form = UserProfileForm(request.POST or None)
        
        if user_form.is_valid() and user_profile_form.is_valid():
            new_user = user_form.save(commit=False)
            new_user.set_password(user_form.cleaned_data['password'])
            new_user.save()

            new_user_profile = user_profile_form.save(commit=False)
            new_user_profile.user = new_user
            new_user_profile.save()

            return redirect('account:new_user_success')
        else:
            messages.error(request, 'Erro ao realizar o cadastro.')

        return render(request, 'account/register/form_new_user.html', {'user_form': user_form,
            'user_profile_form': user_profile_form})


class UserProfileHomeView(View):
    def get(self, request):
        user_profile = get_object_or_404(UserProfile, user=request.user)

        return render(request, 'account/user/home.html', {'user_profile': user_profile})


class UserProfileView(View):
    def get(self, request):        
        user_profile = get_object_or_404(UserProfile, user=request.user)

        user_profile_form = UserProfileForm(instance=user_profile)        

        return render(request, 'account/user/profile.html', {'user_profile_form': user_profile_form,
            'user_profile': user_profile})
    
    def post(self, request):
        user_profile = get_object_or_404(UserProfile, user=request.user)

        user_profile_form = UserProfileForm(request.POST, instance=user_profile)

        if user_profile_form.is_valid():
            user_profile_form.save()
                     
            messages.success(request, 'Seus dados foram atualizados com sucesso.')
        else:
            messages.error(request, 'Erro ao atualizar dados do usuário.')
                
        return redirect('account:profile')
