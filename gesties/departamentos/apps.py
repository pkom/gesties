# -*- coding: utf-8 -*-
from django.apps import AppConfig


class DepartamentosConfig(AppConfig):

    name = 'gesties.departamentos'
    verbose_name = "Departamentos Académicos"

    def ready(self):
        """Override this to put in:
            Users system checks
            Users signal registration
        """
        pass
