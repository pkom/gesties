# -*- coding: utf-8 -*-
from django.apps import AppConfig


class GruposConfig(AppConfig):
    name = 'gesties.grupos'
    verbose_name = "Grupos Académicos"

    def ready(self):
        """Override this to put in:
            Users system checks
            Users signal registration
        """
        pass
