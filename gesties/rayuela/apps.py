# -*- coding: utf-8 -*-
from django.apps import AppConfig


class RayuelaConfig(AppConfig):
    name = 'gesties.rayuela'
    verbose_name = "Importación desde Rayuela"

    def ready(self):
        """Override this to put in:
            Users system checks
            Users signal registration
        """
        pass

