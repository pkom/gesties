# -*- coding: utf-8 -*-
# Generated by Django 1.10.2 on 2017-11-12 12:29
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('libros', '0016_auto_20171112_1313'),
    ]

    operations = [
        migrations.AlterField(
            model_name='prestamo',
            name='fecha_fin_prestamo',
            field=models.DateTimeField(blank=True, db_index=True, null=True),
        ),
    ]
