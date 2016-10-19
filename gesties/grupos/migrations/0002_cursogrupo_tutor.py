# -*- coding: utf-8 -*-
# Generated by Django 1.10.2 on 2016-10-19 09:37
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('grupos', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='cursogrupo',
            name='tutor',
            field=models.ForeignKey(default=None, on_delete=django.db.models.deletion.CASCADE, related_name='tutores', to=settings.AUTH_USER_MODEL),
        ),
    ]