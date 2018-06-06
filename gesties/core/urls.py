# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.conf.urls import include, url

from .listados import listin_telefonico, etiquetas_alumnos, imprime_cb_ejemplares, imprime_libros, imprime_ejemplares_prestados
from .views import load_index, load_traspaso, load_sidebar, locales


urlpatterns = [
    # ajax carga_index
    url(r'^index/$', load_index, name='index'),

    # traspado de datos entre cursos
    url(r'^traspaso/$', load_traspaso.as_view(), name='traspaso_datos'),

    # impresión de códigos de barras ejemplares
    url(r'^imprime_cb_ejemplares/$', imprime_cb_ejemplares, name='imprime_cb_ejemplares'),
    # impresión de informe de libros
    url(r'^imprime_libros/$', imprime_libros, name='imprime_libros'),
    # impresión de informe de libros
    url(r'^imprime_libros/(?P<orden>[\w-]+)$', imprime_libros, name='imprime_libros_orden'),
    # impresión de informe de ejemplares de libros prestados
    url(r'^imprime_ejemplares_prestados/$', imprime_ejemplares_prestados, name='imprime_ejemplares_prestados'),

    url(r'^listin/$', listin_telefonico, name='listin_defecto'),
    url(r'^listin/(?P<curso>[\w-]+)/$', listin_telefonico, name='listin_curso'),
    url(r'^listin/(?P<curso>[\w-]+)/(?P<grupo>[\w-]+)/$', listin_telefonico,
      name='listin_grupo'),
    url(r'^etiquetas/$', etiquetas_alumnos, name='etiquetas_defecto'),
    url(r'^etiquetas/(?P<curso>[\w-]+)/$', etiquetas_alumnos, name='etiquetas_curso'),
    url(r'^etiquetas/(?P<curso>[\w-]+)/(?P<grupo>[\w-]+)/$', etiquetas_alumnos,
      name='etiquetas_grupo'),

    # ajax carga sidebar
    url(r'^carga_sidebar/$', load_sidebar, name='carga_sidebar'),

    # chequeo de locales
    url(r'^locales/$', locales, name='chequeo_locales'),

]
