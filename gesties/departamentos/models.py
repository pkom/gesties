# -*- coding: utf-8 -*-
from __future__ import unicode_literals, absolute_import
from slugify import slugify

from django.conf import settings
from django.utils.encoding import python_2_unicode_compatible
from django.db import models
from model_utils.models import TimeStampedModel

from gesties.cursos.models import Curso

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

    curso = models.ForeignKey(Curso, related_name='cursodepartamentos')
    departamento = models.ForeignKey(Departamento, related_name='departamentos')
    jefe = models.ForeignKey(settings.AUTH_USER_MODEL, related_name='jefe', blank=True, null=True)

    def __str__(self):
        return u"{0} - {1} - {2}".format(self.curso, self.departamento, self.jefe if self.jefe else 'Sin asignar jefatura')

    class Meta:
        verbose_name = "Departamentos por curso"
        unique_together = (("curso", "departamento"),)
        ordering = [ 'curso__curso', 'departamento__departamento' ]


class CursoDepartamentoProfesor(TimeStampedModel):

    curso_departamento = models.ForeignKey(CursoDepartamento, related_name='cursodepartamentosprofesores')
    profesor = models.ForeignKey(settings.AUTH_USER_MODEL, related_name='profesoresdepartamento')

    def __str__(self):
        return u"{0} - {1} ".format(self.curso_departamento, self.profesor)

    class Meta:
        verbose_name = "Profesores por Departamentos y curso"
        unique_together = (("curso_departamento", "profesor"),)
        ordering = [ 'curso_departamento__curso', 'curso_departamento__departamento', 'profesor__last_name',
                     'profesor__first_name' ]
