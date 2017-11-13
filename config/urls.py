# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.conf import settings
from django.conf.urls import include, url
from django.conf.urls.static import static
from django.contrib import admin
from django.views import defaults as default_views

from gesties.core.views import index

admin.site.site_header = u"Administración Gesties"

urlpatterns = [
    url(r'^$', index, name='home'),

    # Django Admin, use {% url 'admin:index' %}
    url(settings.ADMIN_URL, admin.site.urls),

    # User management, profesores
    url(r'^users/', include('gesties.users.urls', namespace='users')),
    #url(r'^accounts/', include('allauth.urls')),

    # Your stuff: custom urls includes go here

    # Préstamos de libros de texto
    url(r'^libros/', include('gesties.libros.urls', namespace='libros')),

    # Alumnos y tutores legales
    url(r'^alumnos/', include('gesties.alumnos.urls', namespace='alumnos')),

    # Departamentos
    url(r'^departamentos/', include('gesties.departamentos.urls', namespace='departamentos')),

    # Grupos
    url(r'^grupos/', include('gesties.grupos.urls', namespace='grupos')),

    # core - inicio
    url(r'^inicio/', include('gesties.core.urls', namespace='inicio')),

    # api
    url(r'^api/', include('gesties.api.urls', namespace='api')),
    # api auth
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),

    ] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

if settings.DEBUG:
    # This allows the error pages to be debugged during development, just visit
    # these url in browser to see how these error pages look like.
    urlpatterns += [
        url(r'^400/$', default_views.bad_request, kwargs={'exception': Exception('Bad Request!')}),
        url(r'^403/$', default_views.permission_denied, kwargs={'exception': Exception('Permission Denied')}),
        url(r'^404/$', default_views.page_not_found, kwargs={'exception': Exception('Page not Found')}),
        url(r'^500/$', default_views.server_error),
    ]
    if 'debug_toolbar' in settings.INSTALLED_APPS:
        import debug_toolbar

        urlpatterns += [
            url(r'^__debug__/', include(debug_toolbar.urls)),
        ]
