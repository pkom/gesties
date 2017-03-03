# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.conf.urls import url
from django.contrib.auth import views as auth_views

from gesties.users import views

urlpatterns = [
#    url(r'^login/$', auth_views.login, name='login'),
    url(r'^login/$', views.Userlogin, name='login'),
    url(r'^logout/$', auth_views.logout, name='logout'),

    # ajax load teachers page
    url(r'^profesores/$', views.load_profesores, name='profesores'),

    # ajax load teachers datatables
    url(r'^carga_profesores_datatables/$', views.load_profesores_datatables, name='carga_profesores_datatables'),

    # ajax load teacher info
    url(r'^carga_profesor_info/(?P<dni>[\w.@+-]+)/$', views.ver_profesor, name='ver_profesor'),
    url(r'^carga_profesor_info/$', views.ver_profesor, name='ver_profesor'),



    url(
        regex=r'profesores/$',
        view=views.CursoProfesorListView.as_view(),
        name='list-profesores'
    ),
    url(
        regex=r'profesores/~redirect/$',
        view=views.UserRedirectView.as_view(),
        name='redirect-profesores'
    ),
    url(
        regex=r'profesores/(?P<username>[\w.@+-]+)/$',
        view=views.CursoProfesorDetailView.as_view(),
        name='detail-profesor'
    ),
    url(
        regex=r'profesores/~update/$',
        view=views.UserUpdateView.as_view(),
        name='update-profesor'
    ),

]
