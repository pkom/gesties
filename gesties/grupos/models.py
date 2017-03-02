# -*- coding: utf-8 -*-
from __future__ import unicode_literals, absolute_import
from slugify import slugify

from django.conf import settings
from django.utils.encoding import python_2_unicode_compatible
from django.db import models
from model_utils.models import TimeStampedModel

from gesties.alumnos.models import CursoAlumno
from gesties.users.models import CursoProfesor
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

    curso = models.ForeignKey(Curso, on_delete=models.CASCADE,
                              related_name='grupos')
    grupo = models.ForeignKey(Grupo, on_delete=models.CASCADE,
                              related_name='cursos')
    tutor = models.ForeignKey(CursoProfesor, on_delete=models.CASCADE,
                              related_name="tutorias", blank=True, null=True)

    def __str__(self):
        return u"{0} - {1} - {2}".format(self.curso, self.grupo, self.tutor if self.tutor else 'Sin asignar tutoría')

    class Meta:
        verbose_name = "Grupos por curso"
        unique_together = (("curso", "grupo"),)
        ordering = [ 'curso__curso', 'grupo__grupo' ]


class CursoGrupoAlumno(TimeStampedModel):

    curso_grupo = models.ForeignKey(CursoGrupo, on_delete=models.CASCADE,
                                    related_name='alumnos')
    curso_alumno = models.ForeignKey(CursoAlumno, on_delete=models.CASCADE,
                                     related_name='grupos')

    def __str__(self):
        return u"{0} - {1} ".format(self.curso_grupo, self.curso_alumno)

    def foto_html(self):
        return self.curso_alumno.alumno.foto_html()
    foto_html.short_description = 'Fotografía'

    class Meta:
        verbose_name = "Grupos y Alumn@"
        #unique_together = (("curso_grupo", "alumno"),)
        ordering = [ 'curso_grupo__curso', 'curso_grupo__grupo', 'curso_alumno__alumno', ]


class CursoGrupoProfesor(TimeStampedModel):

    curso_grupo = models.ForeignKey(CursoGrupo, on_delete=models.CASCADE,
                                    related_name='profesores')
    curso_profesor = models.ForeignKey(CursoProfesor, on_delete=models.CASCADE,
                                       related_name='grupos')

    def __str__(self):
        return u"{0} - {1} ".format(self.curso_grupo, self.curso_profesor)

    def foto_html(self):
        return self.curso_profesor.profesor.foto_html()
    foto_html.short_description = 'Fotografía'

    class Meta:
        verbose_name = "Grupos y Profesor@"
        #unique_together = (("curso_grupo", "curso_profesor"),)
        ordering = [ 'curso_grupo__curso', 'curso_grupo__grupo', 'curso_profesor__profesor', ]
