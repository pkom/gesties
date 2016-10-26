# -*- coding: utf-8 -*-
from django.apps import AppConfig


class ConfigiesConfig(AppConfig):
    name = 'gesties.configies'
    verbose_name = "Configuración"


def ready(self):
    """Override this to put in:
        Users system checks
        Users signal registration
    """
    pass
