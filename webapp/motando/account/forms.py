#
# account/forms.py
#

import re

from django import forms
from django.shortcuts import get_object_or_404
from django.contrib.auth import get_user_model

from .models import User, UserProfile
from state_city.models import State, StateCity
from motorcycle.models import MotorcycleBrandModel
  

class LoginForm(forms.Form):
    email = forms.CharField(max_length=255,
        widget=forms.EmailInput(attrs={'class': 'form-control', 'placeholder': 'E-mail'})
    )

    password = forms.CharField(max_length=30,
        widget=forms.PasswordInput(attrs={'class': 'form-control', 'placeholder': 'Senha'})
    )


class UserRegistrationForm(forms.ModelForm):
    fullname = forms.CharField(max_length=500, required=True,
        widget=forms.TextInput(attrs={'class': 'form-control my-btn-outline', 'style': 'box-shadow: none;'})
    )

    email = forms.CharField(max_length=255, required=True,
        widget=forms.EmailInput(attrs={'class': 'form-control my-btn-outline', 'style': 'box-shadow: none;'})
    )

    email_confirm = forms.CharField(max_length=255, required=True,
        widget=forms.EmailInput(attrs={'class': 'form-control my-btn-outline', 'style': 'box-shadow: none;'})
    )

    password = forms.CharField(max_length=30, required=True,
       widget=forms.PasswordInput(attrs={'class': 'form-control my-btn-outline', 'style': 'box-shadow: none;'})
    )

    password_confirm = forms.CharField(max_length=30, required=True,
       widget=forms.PasswordInput(attrs={'class': 'form-control my-btn-outline', 'style': 'box-shadow: none;'})
    )

    class Meta:
        model = get_user_model()
        fields = ('email', 'fullname',)

    def clean_password_confirm(self):
        cleaned_data = self.cleaned_data

        if cleaned_data['password'] != cleaned_data['password_confirm']:
            raise forms.ValidationError('As senhas não são iguais.')

        return cleaned_data['password_confirm']

    def clean_email_confirm(self):
        cleaned_data = self.cleaned_data

        if cleaned_data['email'] != cleaned_data['email_confirm']:
            raise forms.ValidationError('Os emails não são iguais.')

        return cleaned_data['email_confirm']


class UserProfileForm(forms.ModelForm):
    YES_NO_CHOICES = [
        (False, 'Não'),
        (True, 'Sim'),
    ]

    GENDER_CHOICES = [
        ('M', 'Masculino'),
        ('F', 'Feminino'),
    ]

    subscribe_offer = forms.BooleanField(required=False,
        widget=forms.CheckboxInput(
            attrs={'class': 'form-check-input', 'id': 'id_subscribe_offer'}
        )
    )
    
    forms.TypedChoiceField(required=False,
        coerce=lambda x: x == 'True',
        choices=YES_NO_CHOICES,        
        widget=forms.RadioSelect(attrs={'class': 'form-check-input', 'id': 'id_has_motorcycle'})
    )

    state = forms.CharField(label='Estado', required=True,
        widget=forms.Select(
            choices=(), 
            attrs={'class': 'form-select my-btn-outline', 'style': 'box-shadow: none;', 'disabled': 'disabled', 'id': 'id_brazil_state'}
        )
    )

    city = forms.CharField(label='Cidade', required=True,
        widget=forms.Select(
            choices=(), 
            attrs={'class': 'form-select my-btn-outline', 'style': 'box-shadow: none;', 'disabled': 'disabled', 'id': 'id_brazil_state_city'}
        )
    )   

    zip_code = forms.CharField(max_length=40, required=False,
        widget=forms.TextInput(attrs={'class': 'form-control my-btn-outline', 'style': 'box-shadow: none;', 'id': 'id_zip_code'})
    )

    address = forms.CharField(max_length=1000, required=False,
        widget=forms.TextInput(attrs={'class': 'form-control my-btn-outline', 'style': 'box-shadow: none;', 'id': 'id_address'})
    )

    neighborhood = forms.CharField(max_length=100, required=False,
        widget=forms.TextInput(attrs={'class': 'form-control my-btn-outline', 'style': 'box-shadow: none;', 'id': 'id_neighborhood'})
    )

    address_complement = forms.CharField(max_length=500, required=False,
        widget=forms.TextInput(attrs={'class': 'form-control my-btn-outline', 'style': 'box-shadow: none;', 'id': 'id_address_complement'})
    )   

    date_of_birth = forms.DateField(required=False,
        widget=forms.TextInput(attrs={'class': 'form-control my-btn-outline', 'style': 'box-shadow: none;', 'id': 'id_date_of_birth'})
    )

    telephone = forms.CharField(max_length=40, required=True,
        widget=forms.TextInput(attrs={'class': 'form-control my-btn-outline', 'style': 'box-shadow: none;', 'id': 'id_telephone'})
    )

    gender = forms.CharField(label='Sexo', max_length=1, required=False,
        widget=forms.RadioSelect(
            choices=GENDER_CHOICES,
            attrs={'class': 'form-check-input', 'id': 'id_gender'}
        )
    )

    has_motorcycle = forms.TypedChoiceField(required=False,
        coerce=lambda x: x == 'True',
        choices=YES_NO_CHOICES,        
        widget=forms.RadioSelect(attrs={'class': 'form-check-input', 'id': 'id_has_motorcycle'})
    )
   
    motorcycle_brand_wanted = forms.CharField(label='Marca Desejada', required=False,
        widget=forms.Select(
            choices=(), 
            attrs={'class': 'form-select my-btn-outline', 'style': 'box-shadow: none;', 'disabled': 'disabled', 'id': 'id_motorcycle_brand'}
        )
    )

    motorcycle_brand_model_wanted = forms.CharField(label='Modelo Desejado', required=False,
        widget=forms.Select(
            choices=(), 
            attrs={'class': 'form-select my-btn-outline', 'style': 'box-shadow: none;', 'disabled': 'disabled', 'id': 'id_motorcycle_brand_model'}
        )
    )

    motorcycle_wanted_year = forms.CharField(label='Ano do Modelo', max_length=4, required=False,
        widget=forms.TextInput(
            attrs={'class': 'form-control my-btn-outline', 'style': 'box-shadow: none;', 'id': 'id_motorcycle_wanted_year'}
        )
    )

    authz_whatsapp = forms.BooleanField(required=False,
        widget=forms.CheckboxInput(
            attrs={'class': 'form-check-input', 'id': 'id_authz_whatsapp'}
        )
    )

    authz_sms = forms.BooleanField(required=False,
        widget=forms.CheckboxInput(
            attrs={'class': 'form-check-input', 'id': 'id_authz_sms'}
        )
    )

    show_telephone_classifiedad = forms.BooleanField(required=False,
        widget=forms.CheckboxInput(
            attrs={'class': 'form-check-input', 'id': 'id_show_telephone_classifiedad'}
        )
    )  

    class Meta:
        model = UserProfile

        fields = ('state', 'city', 'zip_code', 'address', 'neighborhood',
            'address_complement', 'date_of_birth', 'telephone', 'gender', 
            'has_motorcycle', 'motorcycle_brand_wanted', 'motorcycle_wanted_year',
            'motorcycle_brand_model_wanted', 'authz_whatsapp', 'authz_sms',
            'show_telephone_classifiedad', 'subscribe_offer',)
            
    def clean(self):
        cleaned_data = super(UserProfileForm, self).clean()

        state_id = cleaned_data.get('state')
        city_id = cleaned_data.get('city')       

        state = get_object_or_404(State, id=state_id)
        city = get_object_or_404(StateCity, id=city_id)
        
        cleaned_data['state'] = state
        cleaned_data['city'] = city

        # Keep just the telephone numbers.
        telephone_str = cleaned_data.get('telephone')
        telephone = ''.join([elem for elem in telephone_str if elem.isdigit()])
        cleaned_data['telephone'] = telephone

        motorcycle_brand_id = cleaned_data.get('motorcycle_brand_wanted')
        motorcycle_brand_model_id = cleaned_data.get('motorcycle_brand_model_wanted')
        
        motorcycle_brand = None
        motorcycle_brand_model = None

        try:
            motorcycle_brand_model = MotorcycleBrandModel.objects.filter(
                id=motorcycle_brand_model_id, brand__id=motorcycle_brand_id).get()
        except (ValueError, MotorcycleBrandModel.DoesNotExist,):        
            pass
        else:
            motorcycle_brand = motorcycle_brand_model.brand

        cleaned_data['motorcycle_brand_wanted'] = motorcycle_brand
        cleaned_data['motorcycle_brand_model_wanted'] = motorcycle_brand_model


class PasswordSecurityForm(forms.Form):
    current_password = forms.CharField(label='Senha atual', max_length=30, required=True,
        widget=forms.PasswordInput(attrs={'class': 'form-control my-btn-outline'})
    )

    new_password = forms.CharField(label='Nova Senha', max_length=30, required=True,
        widget=forms.PasswordInput(attrs={'class': 'form-control my-btn-outline'})
    )

    new_password_confirm = forms.CharField(label='Confirmação da Nova Senha', max_length=30, required=True,
        widget=forms.PasswordInput(attrs={'class': 'form-control my-btn-outline'})
    ) 

    def clean_new_password_confirm(self):
        cleaned_data = self.cleaned_data

        if not re.fullmatch(r'[A-Za-z0-9@#$%^&+=]{8,16}', cleaned_data['new_password']):            
            raise forms.ValidationError('A senha exige uma complexidade mínima.')
        elif cleaned_data['new_password'] != cleaned_data['new_password_confirm']:            
            raise forms.ValidationError('As senhas não são iguais.')            

        return cleaned_data['new_password_confirm']