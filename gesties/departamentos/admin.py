# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.contrib import admin
from .models import Departamento, CursoDepartamento, CursoDepartamentoProfesor


@admin.register(Departamento)
class Grupo(admin.ModelAdmin):
    readonly_fields = ['slug']


@admin.register(CursoDepartamento)
class CursoDepartamentoAdmin(admin.ModelAdmin):
    empty_value_display = "Sin Asignar"
    list_filter = ('curso__curso','departamento__departamento',)


@admin.register(CursoDepartamentoProfesor)
class CursoDepartamentoProfesorAdmin(admin.ModelAdmin):
    empty_value_display = "Sin Asignar"
    list_filter = ('curso_departamento__curso__curso', 'curso_departamento__departamento',)
