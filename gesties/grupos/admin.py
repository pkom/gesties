# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.contrib import admin

from gesties.core.admin import (
    CssAdmin, CursoEnlaceAdmin, GrupoEnlaceAdmin, CursoGrupoEnlaceAdmin, CursoAlumnoEnlaceAdmin, CursoProfesorEnlaceAdmin
)

from .models import Grupo, CursoGrupo, CursoGrupoAlumno, CursoGrupoProfesor


@admin.register(Grupo)
class GrupoAdmin(CssAdmin):

    list_display = ('grupo', 'descripcion', 'nivel')
    readonly_fields = ['slug']


@admin.register(CursoGrupo)
class CursoGrupoAdmin(CursoEnlaceAdmin, GrupoEnlaceAdmin):

    empty_value_display = "Sin Asignar"
    list_display = ('id', 'curso_link', 'grupo_link', 'tutor',)
    list_filter = ('curso__curso', 'grupo__grupo')


@admin.register(CursoGrupoAlumno)
class CursoGrupoAlumnoAdmin(CursoGrupoEnlaceAdmin, CursoAlumnoEnlaceAdmin):

    list_display = ('id', 'curso_grupo_link', 'curso_alumno_link', 'foto_html',)
    search_fields = ('curso_alumno__alumno__apellidos','curso_alumno__alumno__nombre', 'curso_grupo__grupo__grupo',)
    list_filter = ('curso_grupo__curso__curso','curso_grupo__grupo__grupo')


@admin.register(CursoGrupoProfesor)
class CursoGrupoProfesorAdmin(CursoGrupoEnlaceAdmin, CursoProfesorEnlaceAdmin):

    list_display = ('id', 'curso_grupo_link', 'curso_profesor_link', 'foto_html',)
    search_fields = ('curso_profesor__profesor__last_name','curso_profesor__profesor__first_name','curso_grupo__grupo__grupo',)
    list_filter = ('curso_grupo__curso__curso','curso_grupo__grupo__grupo',)

