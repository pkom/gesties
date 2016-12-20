# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.conf import settings
from django.conf.urls import include, url
from django.conf.urls.static import static
from django.contrib import admin
from django.views.generic import TemplateView
from django.views import defaults as default_views

from gesties.utils.listados import listin_telefonico, etiquetas_alumnos
from gesties.utils.views import index, about

urlpatterns = [
    url(r'^$', index, name='home'),
    url(r'^about/$', about, name='about'),

    # Django Admin, use {% url 'admin:index' %}
    url(settings.ADMIN_URL, admin.site.urls),

    # User management
    url(r'^users/', include('gesties.users.urls', namespace='users')),
    #url(r'^accounts/', include('allauth.urls')),

    # Your stuff: custom urls includes go here
    url(r'^listados/listin/$', listin_telefonico, name='listin_defecto'),
    url(r'^listados/listin/(?P<curso>[\w-]+)/$', listin_telefonico, name='listin_curso'),
    url(r'^listados/listin/(?P<curso>[\w-]+)/(?P<grupo>[\w-]+)/$', listin_telefonico, name='listin_grupo'),
    url(r'^listados/etiquetas/$', etiquetas_alumnos, name='etiquetas_defecto'),
    url(r'^listados/etiquetas/(?P<curso>[\w-]+)/$', etiquetas_alumnos, name='etiquetas_curso'),
    url(r'^listados/etiquetas/(?P<curso>[\w-]+)/(?P<grupo>[\w-]+)/$', etiquetas_alumnos, name='etiquetas_grupo'),
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
