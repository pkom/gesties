# -*- coding: utf-8 -*-
# Generated by Django 1.10.2 on 2016-10-18 16:03
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('alumnos', '0005_auto_20161018_1802'),
    ]

    operations = [
        migrations.AlterField(
            model_name='alumno',
            name='email',
            field=models.EmailField(blank=True, max_length=50),
        ),
    ]
