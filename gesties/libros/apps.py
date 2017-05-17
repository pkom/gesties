# -*- coding: utf-8 -*-
from django.apps import AppConfig


class LibrosConfig(AppConfig):
    name = 'gesties.libros'
    verbose_name = "Libros de Texto"


def ready(self):
    """Override this to put in:
        Users system checks
        Users signal registration
    """
    pass
