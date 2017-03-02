# -*- coding: utf-8 -*-
from __future__ import unicode_literals, absolute_import
from slugify import slugify

from django.conf import settings
from django.utils.encoding import python_2_unicode_compatible
from django.db import models
from model_utils.models import TimeStampedModel

from gesties.cursos.models import Curso
from gesties.users.models import CursoProfesor

@python_2_unicode_compatible
class Departamento(TimeStampedModel):

    departamento = models.CharField(max_length= 100, db_index=True, unique=True)
    descripcion = models.CharField(max_length=100, blank=True)
    slug = models.SlugField(unique=True, max_length=100)

    def __str__(self):
        return u"{0}".format(self.departamento)

    def save(self, *args, **kwargs):
        self.slug = slugify(self.departamento)
        super(Departamento, self).save(*args, **kwargs)

    class Meta:
        verbose_name = 'departamento'
        verbose_name_plural = 'departamentos académicos'
        ordering = [ 'departamento' ]


class CursoDepartamento(TimeStampedModel):

    curso = models.ForeignKey(Curso, on_delete=models.CASCADE,
                              related_name='departamentos')
    departamento = models.ForeignKey(Departamento, on_delete=models.CASCADE,
                                     related_name='cursos')
    jefe = models.ForeignKey(CursoProfesor, on_delete=models.CASCADE,
                             related_name='jefaturas', blank=True, null=True)

    def __str__(self):
        return u"{0} - {1} - {2}".format(self.curso, self.departamento, self.jefe if self.jefe else 'Sin asignar jefatura')

    class Meta:
        verbose_name = "Departamentos por curso"
        unique_together = (("curso", "departamento"),)
        ordering = [ 'curso__curso', 'departamento__departamento' ]


class CursoDepartamentoProfesor(TimeStampedModel):

    curso_departamento = models.ForeignKey(CursoDepartamento, on_delete=models.CASCADE,
                                           related_name='profesores')
    curso_profesor = models.ForeignKey(CursoProfesor, on_delete=models.CASCADE,
                                 related_name='departamentos')

    def __str__(self):
        return u"{0} - {1} ".format(self.curso_departamento, self.curso_profesor)

    def foto_html(self):
        return self.curso_profesor.foto_html()
    foto_html.short_description = u'Fotografía'

    class Meta:
        verbose_name = "Departamentos y profesor@"
        unique_together = (("curso_departamento", "curso_profesor"),)
        ordering = [ 'curso_departamento__curso', 'curso_departamento__departamento', 'curso_profesor__profesor__last_name',
                     'curso_profesor__profesor__first_name' ]
