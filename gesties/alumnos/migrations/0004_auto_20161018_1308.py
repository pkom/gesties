# -*- coding: utf-8 -*-
# Generated by Django 1.10.2 on 2016-10-18 11:08
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('alumnos', '0003_auto_20161018_1305'),
    ]

    operations = [
        migrations.AlterField(
            model_name='tutor',
            name='alumnos',
            field=models.ManyToManyField(blank=True, related_name='tutores', to='alumnos.Alumno'),
        ),
    ]
