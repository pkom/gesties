# -*- coding: utf-8 -*-
from __future__ import unicode_literals, absolute_import

from django.utils.encoding import python_2_unicode_compatible
from django.db import models
from django.utils.html import format_html
from model_utils.models import TimeStampedModel

from gesties.cursos.models import Curso


@python_2_unicode_compatible
class Rayuela(TimeStampedModel):
    TIPO = (
        ('PR', 'Profesores XML Rayuela'),
        ('AL', 'Alumnos ZIP Rayuela'),
        ('DA', 'Datos adicionales alumnos ODS rayuela'),
        ('TU', 'Datos de tutores legales ODS rayuela'),
    )
    curso = models.ForeignKey(Curso)
    tipo = models.CharField(max_length=2, choices=TIPO)
    archivo = models.FileField(upload_to='rayuela/%Y/%m/%d')
    procesado = models.BooleanField(default=False)
    resultado = models.TextField(null=True, blank=True)

    def __str__(self):
        return u"{0} {1} [{2}]".format(self.curso, self.get_tipo_display(), self.archivo)

    def resultado_html(self, width=48, heigth=48):
        return format_html(self.resultado)

    resultado_html.short_description = u'Resultado de la importación de datos'
    resultado_html.allow_tags = True

    class Meta:
        verbose_name = 'rayuela'
        verbose_name_plural = 'importacion rayuela'
        ordering = [ '-curso', '-created' ]
