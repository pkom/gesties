# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.conf.urls import url

from . import views


urlpatterns = [
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
