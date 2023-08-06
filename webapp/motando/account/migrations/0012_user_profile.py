# Generated by Django 4.2.4 on 2023-08-04 13:51

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0011_alter_userprofile_motorcycle_wanted_year'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='profile',
            field=models.OneToOneField(default=None, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='profile', to='account.userprofile'),
        ),
    ]