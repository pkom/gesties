# -*- coding: utf-8 -*-
from django.apps import AppConfig


class UsersConfig(AppConfig):
    name = 'gesties.users'
    verbose_name = "Usuarios"

    def ready(self):
        """Override this to put in:
            Users system checks
            Users signal registration
        """
        pass
