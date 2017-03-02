# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.core.urlresolvers import reverse
from django.contrib import admin
from django.utils.html import format_html


class CssAdmin(admin.ModelAdmin):

    class Media:
        css = {
            'all': ('css/admin/mi_admin.css',)
        }


class CursoEnlaceAdmin(CssAdmin):

    def curso_link(self, obj):
        url = reverse('admin:%s_%s_change' % ('cursos', 'curso'), args=[obj.curso.id])
        return format_html('<a href={}>{}</a>', url, obj.curso,
        )
    curso_link.short_description = u'Curso'
    curso_link.allow_tags = True


class AlumnoEnlaceAdmin(CssAdmin):
    def alumno_link(self, obj):
        url = reverse('admin:%s_%s_change' % ('alumnos', 'alumno'), args=[obj.alumno.id])
        return format_html(
            '<a href={}>{}</a>', url, obj.alumno,
        )
    alumno_link.short_description = u'Alumn@'
    alumno_link.allow_tags = True


class ProfesorEnlaceAdmin(CssAdmin):
    def profesor_link(self, obj):
        url = reverse('admin:%s_%s_change' % ('users', 'user'), args=[obj.profesor.id])
        return format_html(
            '<a href={}>{}</a>', url, obj.profesor,
        )
    profesor_link.short_description = u'Curso Profesor'
    profesor_link.allow_tags = True


class GrupoEnlaceAdmin(CssAdmin):
    def grupo_link(self, obj):
        url = reverse('admin:%s_%s_change' % ('grupos', 'grupo'), args=[obj.grupo.id])
        return format_html(
            '<a href={}>{}</a>', url, obj.grupo,
        )
    grupo_link.short_description = u'Grupo'
    grupo_link.allow_tags = True


class DepartamentoEnlaceAdmin(CssAdmin):
    def departamento_link(self, obj):
        url = reverse('admin:%s_%s_change' % ('departamentos', 'departamento'), args=[obj.departamento.id])
        return format_html(
            '<a href={}>{}</a>', url, obj.departamento,
        )
    departamento_link.short_description = u'Departamento'
    departamento_link.allow_tags = True


class CursoGrupoEnlaceAdmin(CssAdmin):
    def curso_grupo_link(self, obj):
        url = reverse('admin:%s_%s_change' % ('grupos', 'cursogrupo'), args=[obj.curso_grupo.id])
        return format_html(
            '<a href={}>{}</a>', url, obj.curso_grupo,
        )
    curso_grupo_link.short_description = u'Curso Grupo'
    curso_grupo_link.allow_tags = True


class CursoDepartamentoEnlaceAdmin(CssAdmin):
    def curso_departamento_link(self, obj):
        url = reverse('admin:%s_%s_change' % ('departamentos', 'cursodepartamento'), args=[obj.curso_departamento.id])
        return format_html(
            '<a href={}>{}</a>', url, obj.curso_departamento,
        )
    curso_departamento_link.short_description = u'Curso Departamento'
    curso_departamento_link.allow_tags = True


class CursoAlumnoEnlaceAdmin(CssAdmin):
    def curso_alumno_link(self, obj):
        url = reverse('admin:%s_%s_change' % ('alumnos', 'cursoalumno'), args=[obj.curso_alumno.id])
        return format_html(
            '<a href={}>{}</a>', url, obj.curso_alumno,
        )
    curso_alumno_link.short_description = u'Curso Alumno'
    curso_alumno_link.allow_tags = True


class CursoProfesorEnlaceAdmin(CssAdmin):
    def curso_profesor_link(self, obj):
        url = reverse('admin:%s_%s_change' % ('users', 'cursoprofesor'), args=[obj.curso_profesor.id])
        return format_html(
            '<a href={}>{}</a>', url, obj.curso_profesor,
        )
    curso_profesor_link.short_description = u'Curso Profesor'
    curso_profesor_link.allow_tags = True
