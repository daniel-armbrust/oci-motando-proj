#
# motandoadm/forms.py
#

from django import forms

from motorcycle.models import MotorcycleBrand, MotorcycleBrandModel, MotorcycleBrandModelVersion


class MotorcycleBrandForm(forms.ModelForm):    
    class Meta:
        model = MotorcycleBrand
        fields = ('brand',)
        labels = {'brand': 'Marca'}

        widgets = {
            'brand': forms.TextInput(attrs={'class': 'form-control'})
        }


class MotorcycleBrandModelForm(forms.ModelForm):        
    class Meta:
        model = MotorcycleBrandModel
        fields = ('brand', 'model',)
        labels = {'brand': 'Marca', 'model': 'Modelo'}

        widgets = {
            'brand': forms.Select(attrs={'class': 'form-control', 'readonly': True}),
            'model': forms.TextInput(attrs={'class': 'form-control'})
        }


class MotorcycleBrandModelVersionForm(forms.ModelForm):        
    class Meta:
        model = MotorcycleBrandModelVersion
        fields = ('model', 'version',)
        labels = {'model': 'Marca - Modelo', 'version': 'Versão'}

        widgets = {        
            'model': forms.Select(attrs={'class': 'form-control', 'readonly': True}),
            'version': forms.TextInput(attrs={'class': 'form-control'})
        }