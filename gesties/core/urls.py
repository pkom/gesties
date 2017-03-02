# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.conf.urls import include, url

from .listados import listin_telefonico, etiquetas_alumnos
from .views import load_index, load_sidebar


urlpatterns = [
    # ajax carga_index
    url(r'^index/$', load_index, name='index'),

    # ajax carga sidebar
    url(r'^carga_sidebar/$', load_sidebar, name='carga_sidebar'),

    url(r'^listin/$', listin_telefonico, name='listin_defecto'),
    url(r'^listin/(?P<curso>[\w-]+)/$', listin_telefonico, name='listin_curso'),
    url(r'^listin/(?P<curso>[\w-]+)/(?P<grupo>[\w-]+)/$', listin_telefonico,
      name='listin_grupo'),
    url(r'^etiquetas/$', etiquetas_alumnos, name='etiquetas_defecto'),
    url(r'^etiquetas/(?P<curso>[\w-]+)/$', etiquetas_alumnos, name='etiquetas_curso'),
    url(r'^etiquetas/(?P<curso>[\w-]+)/(?P<grupo>[\w-]+)/$', etiquetas_alumnos,
      name='etiquetas_grupo'),
]
