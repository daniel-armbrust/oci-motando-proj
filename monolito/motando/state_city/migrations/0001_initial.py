# Generated by Django 4.2.1 on 2023-05-06 19:56

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='State',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('state', models.CharField(max_length=100)),
                ('acronym', models.CharField(max_length=2, unique=True)),
            ],
            options={
                'db_table': 'states',
            },
        ),
        migrations.CreateModel(
            name='StateCity',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('city', models.CharField(max_length=100)),
                ('state', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='state_cities', to='state_city.state')),
            ],
            options={
                'db_table': 'cities',
            },
        ),
    ]
