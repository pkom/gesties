# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.contrib import admin

from gesties.core.admin import CssAdmin, CursoEnlaceAdmin, DepartamentoEnlaceAdmin, CursoDepartamentoEnlaceAdmin, CursoProfesorEnlaceAdmin

from .models import Departamento, CursoDepartamento, CursoDepartamentoProfesor


@admin.register(Departamento)
class DepartamentoAdmin(CssAdmin):
    readonly_fields = ['slug']


@admin.register(CursoDepartamento)
class CursoDepartamentoAdmin(CursoEnlaceAdmin, DepartamentoEnlaceAdmin):
    empty_value_display = "Sin Asignar"
    list_display = ('id', 'curso_link', 'departamento_link', 'jefe',)
    list_filter = ('curso__curso', 'departamento__departamento',)


@admin.register(CursoDepartamentoProfesor)
class CursoDepartamentoProfesorAdmin(CursoDepartamentoEnlaceAdmin, CursoProfesorEnlaceAdmin):
    list_display = ('id', 'curso_departamento_link', 'curso_profesor_link', 'foto_html',)
    search_fields = ('curso_departamento__departamento__departamento',
                     'curso_profesor__profesor__last_name',
                     'curso_profesor__profesor__first_name',)
    list_filter = ('curso_departamento__curso__curso', 'curso_departamento__departamento',)


"""
@admin.register(CursoGrupoProfesor)
class CursoGrupoProfesorAdmin(CursoGrupoEnlaceAdmin, CursoProfesorEnlaceAdmin):
    list_display = ('id', 'curso_grupo_link', 'curso_profesor_link', 'foto_html',)
    search_fields = ('curso_profesor__profesor__last_name','curso_profesor__profesor__first_name','curso_grupo__grupo__grupo',)
    list_filter = ('curso_grupo__curso__curso','curso_grupo__grupo__grupo',)
"""
