# -*- coding: utf-8 -*-
# Generated by Django 1.10.2 on 2017-05-02 11:41
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('libros', '0014_auto_20170428_1309'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='libro',
            name='bajas',
        ),
    ]
