# -*- coding: utf-8 -*-
from __future__ import unicode_literals, absolute_import
from slugify import slugify

from django.utils.encoding import python_2_unicode_compatible
from django.db import models
from model_utils.models import TimeStampedModel


@python_2_unicode_compatible
class Curso(TimeStampedModel):
    curso = models.CharField('Curso', help_text='Curso Académico', unique=True,
                             blank=False, max_length=9, db_index=True)
    retrasos_amonestacion = models.PositiveSmallIntegerField('Número de retrasos para amonestación',
                                                             help_text='Número de retrasos que generan una amonestación',
                                                             default=2)
    retrasos_trimestre = models.BooleanField('Retrasos por trimestres',
                                             help_text='Considerar retrasos en trimestres',
                                             default=True)
    inicio_primer_trimestre = models.DateField('Fecha inicio primer trimestre',
                                               help_text='Fecha de inicio del primer trimestre')
    fin_primer_trimestre = models.DateField('Fecha fin primer trimestre',
                                               help_text='Fecha de fin del primer trimestre')
    inicio_segundo_trimestre = models.DateField('Fecha inicio segundo trimestre',
                                               help_text='Fecha de inicio del segundo')
    fin_segundo_trimestre = models.DateField('Fecha fin segundo trimestre',
                                               help_text='Fecha de fin del segundo trimestre')
    inicio_tercer_trimestre = models.DateField('Fecha inicio tercer trimestre',
                                               help_text='Fecha de inicio del tercer trimestre')
    fin_tercer_primer_trimestre = models.DateField('Fecha fin tercer trimestre',
                                               help_text='Fecha de fin del tercer trimestre')
    slug = models.SlugField('Slug', blank=False, unique=True, max_length=9)

    def __str__(self):
        return self.curso

    def save(self, *args, **kwargs):
        self.slug = slugify(self.curso)
        super(Curso, self).save(*args, **kwargs)

    class Meta:
        verbose_name = 'curso'
        verbose_name_plural = 'cursos'
        ordering = [ 'curso' ]
