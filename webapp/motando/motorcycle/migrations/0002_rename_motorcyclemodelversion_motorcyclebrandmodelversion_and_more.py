# Generated by Django 4.2.1 on 2023-05-24 13:00

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('classifiedad', '0001_initial'),
        ('motorcycle', '0001_initial'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='MotorcycleModelVersion',
            new_name='MotorcycleBrandModelVersion',
        ),
        migrations.AlterModelTable(
            name='motorcyclebrandmodelversion',
            table='motorcycle_brand_models_versions',
        ),
    ]