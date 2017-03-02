# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.conf.urls import url

from gesties.alumnos.views import viewsajax
from . import views

urlpatterns = [

    # ajax carga página de alumnos
    url(r'^alumnos/$', viewsajax.load_alumnos, name='alumnos'),

    # ajax carga alumnos al datatables del template
    url(r'^carga_alumnos_datatables/$', viewsajax.load_alumnos_datatables, name='carga_alumnos_datatables'),

    # ajax load student info
    url(r'^carga_alumno_info/(?P<nie>\d+)/$', viewsajax.ver_alumno, name='ver_alumno'),
    url(r'^carga_alumno_info/$', viewsajax.ver_alumno, name='ver_alumno'),

    # vistas no ajax de alumnos, dependen de la base base.html
    url(
        regex=r'^$',
        view=views.CursoAlumnoListView.as_view(),
        name='list-alumnos'
    ),
    url(
        regex=r'alumnospruebas/$',
        view=viewsajax.CursoAlumnoList,
        name='list-alumnos-pruebas'
    ),
    url(
        regex=r'(?P<nie>\d+)/$',
        view=views.CursoAlumnoDetailView.as_view(),
        name='detail-alumno'
    ),
    url(
        regex=r'alumnos/create/$',
        view=viewsajax.alumno_create,
        name='alumno_create'),
    url(
        regex=r'alumnos/(?P<nie>\d+)/update/$',
        view=viewsajax.alumno_update,
        name='alumno_update'),
    url(
        regex=r'tutores/$',
        view=views.TutorListView.as_view(),
        name='list-tutores'
    ),
    url(
        regex=r'tutores/(?P<dni>[\w.@+-]+)/$',
        view=views.TutorAlumnoDetailView.as_view(),
        name='detail-tutor'
    ),


    # ajax otra prueba
    url(r'^carga_alumnos_json/$', viewsajax.load_alumnos_json, name='carga_alumnos_json'),
    # ajax carga alumnos CRUD samples simpleisbetter
    url(r'^carga_alumnos/$', viewsajax.CursoAlumnoList, name='carga_alumnos'),
    # ajax carga parcial de alumnos
    url(r'^carga_alumnos_parcial/$', viewsajax.CursoAlumnoParcialList, name='carga_alumnos_parcial'),

]
