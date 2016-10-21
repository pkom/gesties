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
    class Media:
        css = {
            'all': ('css/admin/mi_admin.css',)
        }


class TutorAdmin(admin.ModelAdmin):
    list_display = 	('dni', 'apellidos', 'nombre', 'foto_html',)
    search_fields = ('apellidos', 'nombre',)
    class Media:
        css = {
            'all': ('css/admin/mi_admin.css',)
        }


admin.site.register(Alumno, AlumnoAdmin)
admin.site.register(Tutor, TutorAdmin)
