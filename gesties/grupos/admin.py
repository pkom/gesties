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
    list_display = ('curso_grupo', 'alumno', 'foto_html',)
    search_fields = ('alumno__apellidos','alumno__nombre', 'curso_grupo__grupo__grupo',)
    list_filter = ('curso_grupo__curso__curso','curso_grupo__grupo__grupo')

    class Media:
        css = {
            'all': ('css/admin/mi_admin.css',)
        }

@admin.register(CursoGrupoProfesor)
class CursoGrupoProfesorAdmin(admin.ModelAdmin):
    list_display = ('curso_grupo', 'profesor','foto_html',)
    search_fields = ('profesor__last_name','profesor__first_name','curso_grupo__grupo__grupo',)
    list_filter = ('curso_grupo__curso__curso','curso_grupo__grupo__grupo',)

    class Media:
        css = {
            'all': ('css/admin/mi_admin.css',)
        }
