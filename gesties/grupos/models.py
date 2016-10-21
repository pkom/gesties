# -*- coding: utf-8 -*-
from __future__ import unicode_literals, absolute_import
from slugify import slugify

from django.conf import settings
from django.utils.encoding import python_2_unicode_compatible
from django.db import models
from model_utils.models import TimeStampedModel

from gesties.alumnos.models import Alumno
from gesties.cursos.models import Curso

@python_2_unicode_compatible
class Grupo(TimeStampedModel):

    grupo = models.CharField(max_length=50, db_index=True, unique=True)
    descripcion = models.CharField(max_length=50, blank=True)
    slug = models.SlugField(unique=True, max_length=50)

    def __str__(self):
        return u"{0}".format(self.grupo)

    def save(self, *args, **kwargs):
        self.slug = slugify(self.grupo)
        super(Grupo, self).save(*args, **kwargs)

    class Meta:
        verbose_name = 'grupo'
        verbose_name_plural = 'grupos académicos'
        ordering = [ 'grupo' ]


class CursoGrupo(TimeStampedModel):

    curso = models.ForeignKey(Curso, related_name='cursogrupos')
    grupo = models.ForeignKey(Grupo, related_name='grupos')
    tutor = models.ForeignKey(settings.AUTH_USER_MODEL, related_name="tutores", blank=True, null=True)

    def __str__(self):
        return u"{0} - {1} - {2}".format(self.curso, self.grupo, self.tutor if self.tutor else 'Sin asignar tutoría')

    class Meta:
        verbose_name = "Grupos por curso"
        unique_together = (("curso", "grupo"),)
        ordering = [ 'curso__curso', 'grupo__grupo' ]


class CursoGrupoAlumno(TimeStampedModel):

    curso_grupo = models.ForeignKey(CursoGrupo, related_name='cursogruposalumnos')
    alumno = models.ForeignKey(Alumno, related_name='alumnos')

    def __str__(self):
        return u"{0} - {1} ".format(self.curso_grupo, self.alumno)

    def foto_html(self):
        return (self.alumno.foto_html())
    foto_html.short_description = 'Fotografía'

    class Meta:
        verbose_name = "Grupos y alumno/a"
        unique_together = (("curso_grupo", "alumno"),)
        ordering = [ 'curso_grupo__curso', 'curso_grupo__grupo', 'alumno', ]


class CursoGrupoProfesor(TimeStampedModel):

    curso_grupo = models.ForeignKey(CursoGrupo, related_name='cursogruposprofesores')
    profesor = models.ForeignKey(settings.AUTH_USER_MODEL, related_name='profesoresgrupos')

    def __str__(self):
        return u"{0} - {1} ".format(self.curso_grupo, self.profesor)

    def foto_html(self):
        return (self.profesor.foto_html())
    foto_html.short_description = 'Fotografía'

    class Meta:
        verbose_name = "Grupos y profesore/a"
        unique_together = (("curso_grupo", "profesor"),)
        ordering = [ 'curso_grupo__curso', 'curso_grupo__grupo', 'profesor', ]
