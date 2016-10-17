# -*- coding: utf-8 -*-
# Generated by Django 1.10.2 on 2016-10-14 11:05
from __future__ import unicode_literals

from django.db import migrations, models
import gesties.users.models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='dni',
            field=models.CharField(blank=True, db_index=True, help_text='Número del DNI', max_length=20, verbose_name='D.N.I.'),
        ),
        migrations.AddField(
            model_name='user',
            name='es_usuario',
            field=models.BooleanField(default=False, help_text='¿Es usuario/a de Rayuela', verbose_name='¿Es usuario/a de rayuela?'),
        ),
        migrations.AddField(
            model_name='user',
            name='foto',
            field=models.ImageField(blank=True, help_text='Fotografía del usuario/a', upload_to=gesties.users.models.upload_to, verbose_name='Fotografía'),
        ),
        migrations.AddField(
            model_name='user',
            name='id_usuario',
            field=models.CharField(blank=True, help_text='ID Rayuela', max_length=20, verbose_name='ID Rayuela'),
        ),
        migrations.AddField(
            model_name='user',
            name='usuario_rayuela',
            field=models.CharField(blank=True, help_text='Usuario Rayuela', max_length=50, verbose_name='Usuario/a Rayuela'),
        ),
        migrations.AlterField(
            model_name='user',
            name='name',
            field=models.CharField(blank=True, max_length=255, verbose_name='Nombre completo del usuario/a'),
        ),
    ]
