# Generated by Django 4.2.1 on 2023-06-13 16:59

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0007_userprofile_subscribe_offer'),
    ]

    operations = [
        migrations.AddField(
            model_name='userprofile',
            name='authz_sms',
            field=models.BooleanField(default=None, null=True),
        ),
        migrations.AddField(
            model_name='userprofile',
            name='authz_whatsapp',
            field=models.BooleanField(default=None, null=True),
        ),
        migrations.AddField(
            model_name='userprofile',
            name='show_telephone_classifiedad',
            field=models.BooleanField(default=None, null=True),
        ),
    ]
