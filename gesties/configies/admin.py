# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.contrib import admin

from .models import Configies

@admin.register(Configies)
class ConfigiesAdmin(admin.ModelAdmin):
    list_display = ('codigo_centro', 'nombre_centro', 'curso_defecto', 'logo_centro_html')

    class Media:
        css = {
            'all': ('css/admin/mi_admin.css',)
        }
