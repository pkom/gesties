# -*- coding: utf-8 -*-
# Generated by Django 1.10.2 on 2016-10-19 11:59
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('departamentos', '0004_auto_20161019_1236'),
    ]

    operations = [
        migrations.AlterField(
            model_name='cursodepartamentoprofesor',
            name='profesor',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='profesoresdepartamento', to=settings.AUTH_USER_MODEL),
        ),
    ]
