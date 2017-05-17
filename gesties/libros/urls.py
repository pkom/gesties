# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.conf.urls import url

from . import views

urlpatterns = [

    # ajax carga página de libros
    url(r'^libros$', views.load_libros.as_view(), name='libros'),
    # ajax añadir libro
    url(r'^libros/create/$', views.create_libro, name='create_libro'),

    # ajax editar libro
    url(r'^libros/(?P<pk>\d+)/update/$', views.update_libro, name='update_libro'),
    # ajax editar ejemplares
    url(r'^libros/(?P<pk>\d+)/ejemplares/$', views.ejemplares_libro, name='ejemplares_libro'),
    # ajax imprimir código de barras de ejemplares
    url(r'^libros/(?P<pk>\d+)/ejemplares-cb/$', views.imprime_ejemplares_cb, name='imprime_ejemplares_cb'),

    # ajax carga página de préstamos
    url(r'^prestamos/manual$', views.load_prestamos_manual.as_view(), name='prestamos-manual'),
    url(r'^prestamos/automatica$', views.load_prestamos_automatica.as_view(), name='prestamos-automatica'),

    # ajax carga libros al datatables del template
    url(r'^carga_libros_datatables/$', views.load_libros_datatables, name='carga_libros_datatables'),

]
