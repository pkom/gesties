# -*- coding: utf-8 -*-
# Generated by Django 1.10.2 on 2017-01-24 12:31
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('departamentos', '0003_auto_20170124_1203'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='cursodepartamentoprofesor',
            options={'ordering': ['curso_departamento__curso', 'curso_departamento__departamento', 'curso_profesor__profesor__last_name', 'curso_profesor__profesor__first_name'], 'verbose_name': 'Departamentos y profesor@'},
        ),
    ]
