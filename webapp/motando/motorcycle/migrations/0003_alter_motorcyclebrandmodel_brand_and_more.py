# Generated by Django 4.2.4 on 2023-08-04 12:28

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('motorcycle', '0002_rename_motorcyclemodelversion_motorcyclebrandmodelversion_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='motorcyclebrandmodel',
            name='brand',
            field=models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, related_name='brand_models', to='motorcycle.motorcyclebrand'),
        ),
        migrations.AlterField(
            model_name='motorcyclebrandmodelversion',
            name='model',
            field=models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, related_name='model_versions', to='motorcycle.motorcyclebrandmodel'),
        ),
    ]