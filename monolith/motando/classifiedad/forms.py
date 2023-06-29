#
# classifiedad/forms.py
#

from decimal import Decimal

from django import forms
from django.shortcuts import get_object_or_404

from .models import ClassifiedAd
from motorcycle.models import MotorcycleBrandModel


class ClassifiedAdForm(forms.ModelForm):
    brand = forms.CharField(label='Marca', required=True,
        widget=forms.Select(
            choices=(), 
            attrs={'class': 'form-select my-btn-outline', 'style': 'box-shadow: none;', 'disabled': 'disabled'}
        )
    )

    model = forms.CharField(label='Modelo', required=True,
        widget=forms.Select(
            choices=(), 
            attrs={'class': 'form-select my-btn-outline', 'style': 'box-shadow: none;', 'disabled': 'disabled'}
        )
    )

    type = forms.CharField(label='Tipo de Motocicleta', initial='', required=False,
        widget=forms.Select(             
            choices=ClassifiedAd.MOTORCYCLE_TYPE_CHOICES, 
            attrs={'class': 'form-select my-btn-outline', 'style': 'box-shadow: none;'}
        )
    )

    origin = forms.CharField(label='Origem', initial='', required=False,
        widget=forms.Select(             
            choices=ClassifiedAd.ORIGIN_CHOICES, 
            attrs={'class': 'form-select my-btn-outline', 'style': 'box-shadow: none;'}
        )
    )

    fabrication_year = forms.CharField(label='Ano de Fabricação', max_length=4, required=False,
        widget=forms.TextInput(
            attrs={'class': 'form-control my-btn-outline', 'style': 'box-shadow: none;', 
                'placeholder': 'Ano/Fabricação com 4 dígitos'}
        )
    )

    model_year = forms.CharField(label='Ano do Modelo', max_length=4, required=False,
        widget=forms.TextInput(
            attrs={'class': 'form-control my-btn-outline', 'style': 'box-shadow: none;', 
                'placeholder': 'Ano/Modelo com 4 dígitos'}
        )
    )

    license_plate = forms.CharField(label='Placa', max_length=20, required=False,
        widget=forms.TextInput(
            attrs={'class': 'form-control my-btn-outline text-uppercase', 'style': 'box-shadow: none;'}
        )
    )

    is_new = forms.BooleanField(label='Zero KM', required=False,
        widget=forms.CheckboxInput(
            attrs={'class': 'form-check-input', 'style': 'box-shadow: none;'}
        )
    )

    mileage = forms.IntegerField(label='KM', required=False,
        widget=forms.NumberInput(
            attrs={'class': 'form-control my-btn-outline', 'style': 'box-shadow: none;'}
        )
    )

    color = forms.CharField(label='Cor Predominante', initial='', required=False,
        widget=forms.Select(             
            choices=ClassifiedAd.COLOR_CHOICES, 
            attrs={'class': 'form-select my-btn-outline', 'style': 'box-shadow: none;'}
        )
    )   
    
    price = forms.CharField(label='Preço', initial='0.00', required=False, localize=True,
        widget=forms.TextInput(
            attrs={'class': 'form-control my-btn-outline', 'style': 'box-shadow: none;'}
        )
    )

    sales_phrase = forms.CharField(label='Frase Vendedora', max_length=500, required=False,  
        widget=forms.TextInput(
            attrs={'class': 'form-control my-btn-outline', 'style': 'box-shadow: none;'}
        )
    )

    description = forms.CharField(label='Descrição do Anúncio', required=False, max_length=4000,
        widget=forms.Textarea(
            attrs={'style': 'box-shadow: none; background-color: white; resize: none;', 'rows': 10}
        )
    )

    optional_alarm = forms.BooleanField(label='Alarme', required=False,
        widget=forms.CheckboxInput(
            attrs={'class': 'form-check-input'}
        )
    )

    optional_chest = forms.BooleanField(label='Baú / Malas', required=False,
        widget=forms.CheckboxInput(
            attrs={'class': 'form-check-input'}
        )
    )

    optional_computer = forms.BooleanField(label='Computador de Bordo', required=False,
        widget=forms.CheckboxInput(
            attrs={'class': 'form-check-input'}
        )
    )

    optional_gps = forms.BooleanField(label='GPS', required=False,
        widget=forms.CheckboxInput(
            attrs={'class': 'form-check-input'}
        )
    )

    accept_new_offer = forms.BooleanField(label='Aceita contra oferta', required=False,
        widget=forms.CheckboxInput(
            attrs={'class': 'form-check-input'}
        )
    )

    accept_exchange = forms.BooleanField(label='Aceita troca', required=False,
        widget=forms.CheckboxInput(
            attrs={'class': 'form-check-input'}
        )
    )

    doc_ok = forms.BooleanField(label='Documentação em dia', required=False,
        widget=forms.CheckboxInput(
            attrs={'class': 'form-check-input'}
        )
    )

    track_ready = forms.BooleanField(label='Moto preparada para trilha ou pista', required=False,
        widget=forms.CheckboxInput(
            attrs={'class': 'form-check-input'}
        )
    )

    brake_system = forms.CharField(label='Freios', initial='', required=False,
        widget=forms.Select(             
            choices=ClassifiedAd.BRAKE_SYSTEM_CHOICES, 
            attrs={'class': 'form-select my-btn-outline', 'style': 'box-shadow: none;'}
        )
    )

    ignition_system = forms.CharField(label='Tipo de partida', initial='', required=False,
        widget=forms.Select(             
            choices=ClassifiedAd.IGNITION_SYSTEM_CHOICES, 
            attrs={'class': 'form-select my-btn-outline', 'style': 'box-shadow: none;'}
        )
    )

    refrigeration = forms.CharField(label='Refrigeração do Motor', initial='', required=False,
        widget=forms.Select(             
            choices=ClassifiedAd.REFRIGERATION_CHOICES, 
            attrs={'class': 'form-select my-btn-outline', 'style': 'box-shadow: none;'}
        )
    )

    class Meta:
        model = ClassifiedAd

        fields = ('model', 'type', 'origin', 'fabrication_year', 'model_year',
            'license_plate', 'mileage', 'is_new', 'color', 'price', 'sales_phrase',
            'description', 'optional_alarm', 'optional_chest', 'optional_computer',
            'optional_gps', 'accept_new_offer', 'accept_exchange', 'doc_ok',
            'track_ready', 'brake_system', 'ignition_system', 'refrigeration',)       

    def clean(self):
        cleaned_data = super(ClassifiedAdForm, self).clean()

        brand_id = cleaned_data.get('brand')
        model_id = cleaned_data.get('model')

        motorcycle_model = get_object_or_404(
            MotorcycleBrandModel.objects.filter(brand__id=brand_id, id=model_id)
        )  

        cleaned_data['model'] = motorcycle_model        

        price_str = cleaned_data.get('price')
        price_str = price_str.replace(u'\xa0', u'').replace('R$', '')
        price_decimal = Decimal(price_str.replace('.', '').replace(',','.'))
        cleaned_data['price'] = price_decimal

        return cleaned_data


class ClassifiedAdLeaveMsgForm(forms.Form):
    full_name = forms.CharField(label='Nome', max_length=500, required=True,
        widget=forms.TextInput(
            attrs={'class': 'form-control'}
        )
    )

    email = forms.CharField(label='E-mail', required=True,
        widget=forms.EmailInput(
            attrs={'class': 'form-control'}
        )
    )

    telephone = forms.CharField(label='Telefone', max_length=40, required=False,
        widget=forms.TextInput(
            attrs={'class': 'form-control'}
        )
    )

    message = forms.CharField(label='Digite a sua mensagem', required=True, max_length=4000,
        widget=forms.Textarea(
            attrs={'class': 'form-control', 'style': 'height: 100px; resize: none', 'rows': 10}
        )
    )  