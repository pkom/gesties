# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.contrib import admin

from .models import Alumno, CursoAlumno, Tutor

class TutoresInline(admin.TabularInline):
    model = Tutor.alumnos.through
    extra = 2

class AlumnoAdmin(admin.ModelAdmin):
    list_display = 	('nie', 'nombre', 'apellidos', 'fecha_nacimiento', 'foto',)
    search_fields = ('apellidos', 'nombre',)
    inlines = [
        TutoresInline,
    ]

class CursoAlumnoAdmin(admin.ModelAdmin):
    list_display = ('curso', 'alumno',)
    list_filter = ('curso__curso',)

class TutorAdmin(admin.ModelAdmin):
    pass

admin.site.register(Alumno, AlumnoAdmin)
admin.site.register(CursoAlumno, CursoAlumnoAdmin)
admin.site.register(Tutor, TutorAdmin)
