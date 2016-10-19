# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.contrib import admin
from .models import Grupo, CursoGrupo, CursoGrupoAlumno, CursoGrupoProfesor


@admin.register(Grupo)
class Grupo(admin.ModelAdmin):
    readonly_fields = ['slug']


@admin.register(CursoGrupo)
class CursoGrupoAdmin(admin.ModelAdmin):
    list_filter = ('curso__curso',)


@admin.register(CursoGrupoAlumno)
class CursoGrupoAlumnoAdmin(admin.ModelAdmin):
    search_fields = ('alumno__apellidos','alumno__nombre',)
    list_filter = ('curso_grupo__curso__curso','curso_grupo__grupo__grupo')


@admin.register(CursoGrupoProfesor)
class CursoGrupoProfesorAdmin(admin.ModelAdmin):
    search_fields = ('profesor__last_name','profesor__first_name',)
    list_filter = ('curso_grupo__curso__curso','curso_grupo__grupo__grupo',)
