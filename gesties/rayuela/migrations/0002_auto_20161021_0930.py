# -*- coding: utf-8 -*-
# Generated by Django 1.10.2 on 2016-10-21 07:30
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('rayuela', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='rayuela',
            name='tipo',
            field=models.CharField(choices=[('PR', 'Profesores XML Rayuela'), ('AL', 'Alumnos ZIP Rayuela'), ('DA', 'Datos adicionales alumnos ODS rayuela'), ('TU', 'Datos de tutores legales ODS rayuela')], max_length=2),
        ),
    ]
