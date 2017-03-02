# -*- coding: utf-8 -*-
# Generated by Django 1.10.2 on 2017-01-24 11:03
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0001_initial'),
        ('departamentos', '0002_auto_20170123_1230'),
    ]

    operations = [
        migrations.RenameField(
            model_name='cursodepartamentoprofesor',
            old_name='profesor',
            new_name='curso_profesor',
        ),
        migrations.AlterUniqueTogether(
            name='cursodepartamentoprofesor',
            unique_together=set([('curso_departamento', 'curso_profesor')]),
        ),
    ]
