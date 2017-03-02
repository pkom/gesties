# -*- coding: utf-8 -*-
from django.apps import AppConfig


class CoreConfig(AppConfig):
    name = 'gesties.core'
    verbose_name = "Core"

    def ready(self):
        """Override this to put in:
            Users system checks
            Users signal registration
        """
        pass
