# -*- coding: utf-8 -*-
# Generated by Django 1.10.2 on 2016-10-19 17:50
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0002_auto_20161014_1305'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='user',
            options={'ordering': ['last_name', 'first_name'], 'verbose_name': 'usuario', 'verbose_name_plural': 'usuarios'},
        ),
    ]