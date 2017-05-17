# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.contrib import admin

from .models import Autor, Editorial, Area, Ciclo, Nivel, Libro, Ejemplar, Prestamo


admin.site.register(Autor)
admin.site.register(Editorial)
admin.site.register(Area)
admin.site.register(Ciclo)
admin.site.register(Nivel)
admin.site.register(Libro)
admin.site.register(Ejemplar)
admin.site.register(Prestamo)
