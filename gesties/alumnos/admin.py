# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.contrib import admin

from gesties.core.admin import CssAdmin, CursoEnlaceAdmin, AlumnoEnlaceAdmin

from .models import Alumno, CursoAlumno, Tutor


class TutoresInline(admin.TabularInline):
    model = Tutor.alumnos.through
    extra = 2


@admin.register(Alumno)
class AlumnoAdmin(CssAdmin):
    list_display = 	('nie', 'apellidos', 'nombre', 'fecha_nacimiento', 'edad', 'foto_html',)
    search_fields = ('apellidos', 'nombre',)
    readonly_fields = ('edad', )
    inlines = [
        TutoresInline,
    ]


@admin.register(CursoAlumno)
class CursoAlumnoAdmin(CursoEnlaceAdmin, AlumnoEnlaceAdmin):
    list_display = ('id', 'curso_link', 'alumno_link', 'edad', 'foto_html',)
    search_fields = ('alumno__apellidos','alumno__nombre',)
    readonly_fields = ('edad', )
    list_filter = ('curso__curso',)


@admin.register(Tutor)
class TutorAdmin(CssAdmin):
    list_display = 	('dni', 'apellidos', 'nombre', 'foto_html',)
    search_fields = ('apellidos', 'nombre',)
