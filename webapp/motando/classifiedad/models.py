#
# classifiedad/models.py
#

from django.db import models
from django.conf import settings

from motorcycle.models import MotorcycleBrandModel, MotorcycleBrandModelVersion 


class ClassifiedAd(models.Model):
    MOTORCYCLE_TYPE_CHOICES = (        
        ('', '',), ('naked', 'Naked',), ('sport', 'Sport',), ('touring', 'Touring',), 
        ('offroad', 'Off-road',), ('scooter', 'Scooter',), ('motoneta', 'Motoneta',), 
        ('custom', 'Custom',), ('street', 'Street',), ('bigtrail', 'Big Trail',),         
    )

    ORIGIN_CHOICES = (
        ('', '',), ('national', 'Nacional',), ('imported', 'Importada',),
    )

    COLOR_CHOICES = (        
        ('', '',), ('blue', 'Azul',), ('green', 'Verde',), 
        ('red', 'Vermelho',), ('black', 'Preto',), ('white', 'Branco',), 
        ('silver', 'Prata',), ('yellow', 'Amarelo',), ('purple', 'Roxo',)
    )

    BRAKE_SYSTEM_CHOICES = (
        ('', '',), ('abs', 'ABS',), ('tambor', 'Tambor',), 
        ('combined', 'Combinado',),
    )

    IGNITION_SYSTEM_CHOICES = (
        ('', '',), ('pedal', 'Pedal',), ('electric', 'Elétrica',), 
        ('both', 'Ambos',),
    )

    REFRIGERATION_CHOICES = (
        ('', '',), ('air', 'Ar',), ('liquid', 'Líquida',),
    )

    CLASSIFIEDAD_STATUS_CHOICES = (
        ('new', 'Novo',), ('publised', 'Publicado',), 
        ('delete', 'Excluir',), ('expired', 'Expirado',), 
        ('inactive', 'Inativo',), ('update', 'Atualizar',),
    )

    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.DO_NOTHING, null=False)
    model = models.ForeignKey(MotorcycleBrandModel, on_delete=models.DO_NOTHING, null=False) 
    model_version = models.ForeignKey(MotorcycleBrandModelVersion, on_delete=models.DO_NOTHING, null=True, default=None) 
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
    status = models.CharField(max_length=10, choices=CLASSIFIEDAD_STATUS_CHOICES, null=False, default='new')    
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
        return '%s' % (self.url,)









	








