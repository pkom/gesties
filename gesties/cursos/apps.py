# -*- coding: utf-8 -*-
from django.apps import AppConfig


class CursosConfig(AppConfig):
    name = 'gesties.cursos'
    verbose_name = "Cursos"


def ready(self):
    """Override this to put in:
        Users system checks
        Users signal registration
    """
    pass
