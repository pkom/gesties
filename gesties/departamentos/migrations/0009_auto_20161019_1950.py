# -*- coding: utf-8 -*-
# Generated by Django 1.10.2 on 2016-10-19 17:50
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('departamentos', '0008_auto_20161019_1903'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='cursodepartamentoprofesor',
            options={'ordering': ['curso_departamento__curso', 'curso_departamento__departamento', 'profesor__last_name', 'profesor__first_name'], 'verbose_name': 'Profesores por Departamentos y curso'},
        ),
    ]
