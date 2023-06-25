#
# classifiedad/models.py
#

from django.db import models
from django.conf import settings

from motorcycle.models import MotorcycleBrandModel, MotorcycleBrandModelVersion 


class ClassifiedAd(models.Model):
    MOTORCYCLE_TYPE_CHOICES = (        
        ('', '',), ('NAKED', 'Naked',), ('SPORT', 'Sport',), ('TOURING', 'Touring',), 
        ('OFF-ROAD', 'Off-road',), ('SCOOTER', 'Scooter',), ('MOTONETA', 'Motoneta',), 
        ('CUSTOM', 'Custom',), ('STREET', 'Street',), ('BIGTRAIL', 'Big Trail',), 
        ('CUSTOM', 'Custom',), ('STREET', 'Street',),
    )

    ORIGIN_CHOICES = (
        ('', '',), ('NACIONAL', 'Nacional',), ('IMPORTADA', 'Importada',),
    )

    COLOR_CHOICES = (        
        ('', '',), ('AZUL', 'Azul',), ('VERDE', 'Verde',), 
        ('VERMELHO', 'Vermelho',), ('PRETO', 'Preto',), ('BRANCO', 'Branco',), 
    )

    BRAKE_SYSTEM_CHOICES = (
        ('', '',), ('ABS', 'ABS',), ('TAMBOR', 'Tambor',), ('COMBINADO', 'Combinado',),
    )

    IGNITION_SYSTEM_CHOICES = (
        ('', '',), ('PEDAL', 'Pedal',), ('ELETRICA', 'Elétrica',), ('AMBOS', 'Ambos',),
    )

    REFRIGERATION_CHOICES = (
        ('', '',), ('AR', 'Ar',), ('LIQUIDA', 'Líquida',),
    )

    CLASSIFIEDAD_STATUS_CHOICES = (
        ('NEW', 'Novo',), ('PUBLISHED', 'Publicado',), ('DELETE', 'Excluir',), 
        ('EXPIRED', 'Expirado',), ('INACTIVE', 'Inativo',), ('UPDATE', 'Atualizar',),
    )

    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, null=False)
    model = models.ForeignKey(MotorcycleBrandModel, on_delete=models.CASCADE, null=False) 
    model_version = models.ForeignKey(MotorcycleBrandModelVersion, on_delete=models.CASCADE, null=True, default=None) 
    type = models.CharField(max_length=20, choices=MOTORCYCLE_TYPE_CHOICES, null=True, default=None)
    origin = models.CharField(max_length=10, choices=ORIGIN_CHOICES, null=True, default=None)
    fabrication_year = models.PositiveSmallIntegerField(null=False, blank=False)
    model_year = models.PositiveSmallIntegerField(null=False, blank=False)
    license_plate = models.CharField(max_length=20, null=False)
    mileage = models.PositiveIntegerField(null=True, default=None)
    is_new = models.BooleanField(default=False)
    color = models.CharField(max_length=10, choices=COLOR_CHOICES, null=True, blank=False, default=None)
    price = models.DecimalField(max_digits=10, decimal_places=2, null=False, blank=False)
    sales_phrase = models.CharField(max_length=500, null=True, default=None)
    description = models.TextField(max_length=4000, null=True, default=None)
    optional_alarm = models.BooleanField(null=False, default=False)
    optional_chest = models.BooleanField(null=False, default=False)
    optional_computer = models.BooleanField(null=False, default=False)
    optional_gps = models.BooleanField(null=False, default=False)
    accept_new_offer = models.BooleanField(null=False, default=False)
    accept_exchange = models.BooleanField(null=False, default=False)
    doc_ok = models.BooleanField(null=True, default=None)
    track_ready = models.BooleanField(null=True, default=None)
    brake_system = models.CharField(max_length=10, choices=BRAKE_SYSTEM_CHOICES, null=True, default=None)
    ignition_system = models.CharField(max_length=10, choices=IGNITION_SYSTEM_CHOICES, null=True, default=None)
    refrigeration = models.CharField(max_length=10, choices=REFRIGERATION_CHOICES, null=True, default=None)
    status = models.CharField(max_length=10, choices=CLASSIFIEDAD_STATUS_CHOICES, null=False, default='NEW')    
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'classifiedad'
    
    def __str__(self):
        return '%s - %s' % (self.user.email, self.model.model,)


class ClassifiedAdImage(models.Model):
    url = models.URLField(max_length=255, null=False, blank=False)
    classifiedad = models.ForeignKey(ClassifiedAd, on_delete=models.CASCADE, null=False, related_name='images')

    class Meta:
        db_table = 'classifiedad_images'

    def __str__(self):
        return self.classifiedad.model.model









	








