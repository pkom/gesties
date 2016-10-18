from django.apps import AppConfig


class AlumnosConfig(AppConfig):
    name = 'gesties.alumnos'
    verbose_name = "Alumnado y tutores legales"


def ready(self):
    """Override this to put in:
        Users system checks
        Users signal registration
    """
    pass
