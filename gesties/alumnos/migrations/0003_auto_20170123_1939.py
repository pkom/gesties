# -*- coding: utf-8 -*-
# Generated by Django 1.10.2 on 2017-01-23 18:39
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('alumnos', '0002_auto_20170123_1905'),
    ]

    operations = [
        migrations.AlterIndexTogether(
            name='alumno',
            index_together=set([]),
        ),
    ]