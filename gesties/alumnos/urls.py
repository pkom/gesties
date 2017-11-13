# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.conf.urls import url

from . import views

urlpatterns = [

    # ajax carga página de alumnos
    url(r'^alumnos/$', views.load_alumnos, name='alumnos'),

    # ajax carga alumnos al datatables del template
    url(r'^carga_alumnos_datatables/$', views.load_alumnos_datatables, name='carga_alumnos_datatables'),

    # ajax load student info
    url(r'^carga_alumno_info/(?P<nie>\d+)/$', views.ver_alumno, name='ver_alumno'),
    url(r'^carga_alumno_info/$', views.ver_alumno, name='ver_alumno'),

    # ajax carga página de tutores legales
    url(r'^tutores/$', views.load_tutores, name='tutores'),

    # ajax carga tutores al datatables del template
    url(r'^carga_tutores_datatables/$', views.load_tutores_datatables, name='carga_tutores_datatables'),

    # ajax load tutor info
    url(r'^carga_tutor_info/(?P<id>\w+)/$', views.ver_tutor, name='ver_tutor'),
    url(r'^carga_tutor_info/$', views.ver_tutor, name='ver_tutor'),


    # ajax alumnos de un grupo
    url(r'^ajax_carga_alumnos_grupo/(?P<curso_grupo>\d+)/$', views.ajax_carga_alumnos_grupo, name='ajax_carga_alumnos_grupo'),
    url(r'^ajax_carga_alumnos_grupo/$', views.ajax_carga_alumnos_grupo, name='ajax_carga_alumnos_grupo'),
    url(
        regex=r'alumnospruebas/$',
        view=views.CursoAlumnoList,
        name='list-alumnos-pruebas'
    ),
    url(
        regex=r'alumnos/create/$',
        view=views.alumno_create,
        name='alumno_create'),
    url(
        regex=r'alumnos/(?P<nie>\d+)/update/$',
        view=views.alumno_update,
        name='alumno_update'),
    # ajax otra prueba
    url(r'^carga_alumnos_json/$', views.load_alumnos_json, name='carga_alumnos_json'),
    # ajax carga alumnos CRUD samples simpleisbetter
    url(r'^carga_alumnos/$', views.CursoAlumnoList, name='carga_alumnos'),
    # ajax carga parcial de alumnos
    url(r'^carga_alumnos_parcial/$', views.CursoAlumnoParcialList, name='carga_alumnos_parcial'),

]
