# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.conf.urls import url

from . import views


urlpatterns = [
    url(
        regex=r'^$',
        view=views.CursoDepartamentoListView.as_view(),
        name='list-departamentos'
    ),
    url(
        regex=r'(?P<pk>\d+)/$',
        view=views.CursoDepartamentoDetailView.as_view(),
        name='detail-departamento'
    ),

]
