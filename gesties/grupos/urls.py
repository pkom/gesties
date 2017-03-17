# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.conf.urls import url

from . import views


urlpatterns = [

    # ajax carga página de grupos
    url(r'^grupos/$', views.load_grupos, name='grupos'),

    # ajax carga grupos al datatables del template
    url(r'^carga_grupos_datatables/$', views.load_grupos_datatables, name='carga_grupos_datatables'),

    # ajax load group info
    url(r'^carga_grupo_info/(?P<grupo>\w+)/$', views.ver_grupo, name='ver_grupo'),
    url(r'^carga_grupo_info/$', views.ver_grupo, name='ver_grupo'),


    url(
        regex=r'^$',
        view=views.CursoGrupoListView.as_view(),
        name='list-grupos'
    ),
    url(
        regex=r'(?P<pk>\d+)/$',
        view=views.CursoGrupoDetailView.as_view(),
        name='detail-grupo'
    ),

]
