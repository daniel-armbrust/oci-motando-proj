#
# motorcycle/models.py
#

from django.db import models


class MotorcycleBrand(models.Model):
    brand = models.CharField(max_length=50, unique=True, null=False)
    popular = models.BooleanField(default=False, null=False)
    image_url = models.URLField(max_length=255, default=None, null=True, blank=False)

    class Meta:
        db_table = 'motorcycle_brands'

    def __str__(self):
        return '%s' % (self.brand,)


class MotorcycleBrandModel(models.Model):
    model = models.CharField(max_length=50, null=False)
    image_url = models.URLField(max_length=255, default=None, null=True, blank=False)
    brand = models.ForeignKey(MotorcycleBrand, on_delete=models.DO_NOTHING, related_name='brand_models')

    class Meta:
        db_table = 'motorcycle_brand_models'

    def __str__(self):
        return '%s - %s' % (self.brand.brand, self.model,)


class MotorcycleBrandModelVersion(models.Model):
    version = models.CharField(max_length=100)
    image_url = models.URLField(max_length=255, default=None, null=True, blank=False)
    model = models.ForeignKey(MotorcycleBrandModel, on_delete=models.DO_NOTHING, related_name='model_versions')

    class Meta:
        db_table = 'motorcycle_brand_models_versions'

    def __str__(self):
        return '%s - %s (%s)' % (self.model.brand.brand, self.model.model, self.version,)