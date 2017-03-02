# -*- coding: utf-8 -*-
# Generated by Django 1.10.2 on 2017-01-23 11:30
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone
import model_utils.fields


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='CursoDepartamento',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created', model_utils.fields.AutoCreatedField(default=django.utils.timezone.now, editable=False, verbose_name='created')),
                ('modified', model_utils.fields.AutoLastModifiedField(default=django.utils.timezone.now, editable=False, verbose_name='modified')),
            ],
            options={
                'ordering': ['curso__curso', 'departamento__departamento'],
                'verbose_name': 'Departamentos por curso',
            },
        ),
        migrations.CreateModel(
            name='CursoDepartamentoProfesor',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created', model_utils.fields.AutoCreatedField(default=django.utils.timezone.now, editable=False, verbose_name='created')),
                ('modified', model_utils.fields.AutoLastModifiedField(default=django.utils.timezone.now, editable=False, verbose_name='modified')),
                ('curso_departamento', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='profesores', to='departamentos.CursoDepartamento')),
            ],
            options={
                'ordering': ['curso_departamento__curso', 'curso_departamento__departamento', 'profesor__last_name', 'profesor__first_name'],
                'verbose_name': 'Profesores por Departamentos y curso',
            },
        ),
        migrations.CreateModel(
            name='Departamento',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created', model_utils.fields.AutoCreatedField(default=django.utils.timezone.now, editable=False, verbose_name='created')),
                ('modified', model_utils.fields.AutoLastModifiedField(default=django.utils.timezone.now, editable=False, verbose_name='modified')),
                ('departamento', models.CharField(db_index=True, max_length=100, unique=True)),
                ('descripcion', models.CharField(blank=True, max_length=100)),
                ('slug', models.SlugField(max_length=100, unique=True)),
            ],
            options={
                'verbose_name_plural': 'departamentos académicos',
                'ordering': ['departamento'],
                'verbose_name': 'departamento',
            },
        ),
    ]
