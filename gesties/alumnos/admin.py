# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.contrib import admin

from .models import Alumno, Tutor


class TutoresInline(admin.TabularInline):
    model = Tutor.alumnos.through
    extra = 2


class AlumnoAdmin(admin.ModelAdmin):
    list_display = 	('nie', 'apellidos', 'nombre', 'fecha_nacimiento', 'foto_html',)
    search_fields = ('apellidos', 'nombre',)
    inlines = [
        TutoresInline,
    ]


class TutorAdmin(admin.ModelAdmin):
    pass

admin.site.register(Alumno, AlumnoAdmin)
admin.site.register(Tutor, TutorAdmin)
