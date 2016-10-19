# -*- coding: utf-8 -*-
# Generated by Django 1.10.2 on 2016-10-19 16:30
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('departamentos', '0005_auto_20161019_1359'),
    ]

    operations = [
        migrations.AlterField(
            model_name='cursodepartamento',
            name='jefe',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='jefe', to=settings.AUTH_USER_MODEL),
        ),
    ]