# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.conf.urls import url

from . import views


urlpatterns = [

    # ajax carga página de departamentos
    url(r'^departamentos/$', views.load_departamentos, name='departamentos'),

    # ajax carga departamentos al datatables del template
    url(r'^carga_departamentos_datatables/$', views.load_departamentos_datatables, name='carga_departamentos_datatables'),

    # ajax load departament info
    url(r'^carga_departamento_info/(?P<departamento>\w+)/$', views.ver_departamento, name='ver_departamento'),
    url(r'^carga_departamento_info/$', views.ver_departamento, name='ver_departamento'),

]
