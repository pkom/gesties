# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.conf.urls import url, include

from rest_framework.urlpatterns import format_suffix_patterns
# from rest_framework.routers import DefaultRouter

from gesties.api.views.configies import *
from gesties.api.views.cursos import *
from gesties.api.views.grupos import *
from gesties.api.views.alumnos import *
from gesties.api.views.libros import *
from gesties.api.views.authentication import LoginAPIView, UserRetrieveUpdateAPIView

# Create a router and register our viewsets with it.
# router = DefaultRouter()
# router.register(r'snippets', views.SnippetViewSet)
# router.register(r'users', views.UserViewSet)


urlpatterns = [
    # url(r'^', include(router.urls)),

    # api configies
    url(r'^configies/?$', ConfigiesList.as_view(), name='lista-configies'),

    # api listado de usuarios
    url(r'^user/?$', UserRetrieveUpdateAPIView.as_view(), name='lista-usuarios'),
    # api login de usuarios
    url(r'^users/login/?$', LoginAPIView.as_view(), name="login-usuario"),

    # api cursos académicos
    url(r'^cursos/$', CursoList.as_view(), name='cursos-list'),

    # api grupos por curso
    url(r'^grupos/$', CursoGrupoList.as_view(), name='grupos-list'),
    url(r'^grupos/(?P<pk>[0-9]+)/$', CursoGrupoDetail.as_view(), name='grupos-detail'),
    url(r'^grupos/create/$', CursoGrupoCreate.as_view(), name='grupos-create'),
    # api traspaso de alumnos de un grupo y curso a otro, para préstamo de libros cuando no hay matrícula del curso
    url(r'^grupos/create-alumnos/$', CursoGrupoCreateAlumnos.as_view(), name='grupos-create-alumnos'),
    url(r'^grupos/borra-alumnos/$', CursoGrupoDeleteAlumnos.as_view(), name='grupos-delete-alumnos'),

    # api alumnos por grupo
    url(r'^alumnos-grupo/$', CursoGrupoAlumnoList.as_view(), name='alumnos-grupo-list'),
    url(r'^alumnos-grupo/(?P<pk>[0-9]+)/$', CursoGrupoAlumnoDetail.as_view(), name='alumnos-grupo-detail'),
    # api alumnos libros pendientes
    url(r'^alumnos-libros-pendientes/$', CursoGrupoAlumnoLibrosPendientesList.as_view(), name='alumnos-libros-pendientes-list'),
    url(r'^alumnos-libros-prestados/$', CursoGrupoAlumnoLibrosPrestadosList.as_view(), name='alumnos-libros-prestados-list'),

    # api libros ejemplares disponibles
    url(r'^libros-ejemplares-disponibles/$', LibroEjemplaresDisponiblesList.as_view(), name='libros-ejemplares-disponibles-list'),

    # api libros alumno prestar o devolver un ejemplar
    url(r'^libros-alumno-prestar/$', EjemplarLibroAlumnoPrestar, name='libros-alumno-prestar'),
    url(r'^libros-alumno-devolver/$', EjemplarLibroAlumnoDevolver, name='libros-alumno-devolver'),

]

urlpatterns = format_suffix_patterns(urlpatterns)
