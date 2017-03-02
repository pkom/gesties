# -*- coding: utf-8 -*-
from __future__ import unicode_literals, absolute_import

from django.conf import settings
from django.utils.encoding import python_2_unicode_compatible
from django.db import models
from django.utils.html import format_html
from model_utils.models import TimeStampedModel
from django.contrib.staticfiles.templatetags.staticfiles import static
from django.utils.timesince import timesince

from gesties.core.images import fit
from gesties.cursos.models import Curso


@python_2_unicode_compatible
class Alumno(TimeStampedModel):

    nie = models.CharField(unique=True, max_length=15, db_index=True)
    nombre = models.CharField(max_length=100)
    apellidos = models.CharField(max_length=100)
    dni = models.CharField('D.N.I.', help_text='Número del DNI', blank=True, max_length=20, db_index=True)
    direccion = models.CharField('Dirección', help_text='Dirección', blank=True, max_length=200)
    codigo_postal = models.CharField('Código Postal', help_text='Código Postal', blank=True, max_length=10)
    localidad = models.CharField('Localidad', help_text='Localidad', blank=True, max_length=100)
    provincia = models.CharField('Provincia', help_text='Provincia', blank=True, max_length=100)
    fecha_nacimiento = models.DateField(blank=True, null=True)
    usuario_rayuela = models.CharField(max_length=20, blank=True)
    foto = models.ImageField(upload_to='alumnos', max_length=200, blank=True, default='')
    telefono = models.CharField(max_length=50, blank=True)
    email = models.EmailField(max_length=50, blank=True)
    expediente = models.CharField(max_length=10, blank=True)

    def __str__(self):
        return u"{0}, {1}".format(self.apellidos, self.nombre)

    @property
    def get_nombre_completo(self):
        return u"{0}, {1}".format(self.apellidos, self.nombre)

    def foto_html(self, width=48, heigth=48):
        return format_html(
            '<div style="height:{}px;width:{}px;background-repeat:no-repeat;background-position: 50%;'
            'border-radius:50%;background-size:100% auto;background-image:url({})"></div>',
            heigth,
            width,
            self.foto.url if self.foto else static('avatars/nobody.png'),
        )
    foto_html.short_description = u'Fotografía del/la alumno/a'
    foto_html.allow_tags = True

    def edad(self):
        if self.fecha_nacimiento:
            return timesince(self.fecha_nacimiento)
        else:
            return u'No disponible'
    edad.short_description = u'Edad del/la alumno/a'

#    def save(self, *args, **kwargs):
#        super(Alumno, self).save(*args, **kwargs)
#        if self.foto:
#            fit(self.foto.path, settings.MAX_WIDTH, settings.MAX_HEIGHT)

    class Meta:
        verbose_name = "alumn@"
        verbose_name_plural = "alumn@s"
#        index_together = (("apellidos", "nombre"),)
        ordering = ['apellidos', 'nombre' ]


@python_2_unicode_compatible
class CursoAlumno(TimeStampedModel):

    curso = models.ForeignKey(Curso, on_delete=models.CASCADE,
                              related_name='alumnos')
    alumno = models.ForeignKey(Alumno, on_delete=models.CASCADE,
                              related_name='cursos')

    def __str__(self):
        return u"{0} - {1} ".format(self.curso, self.alumno)

    def foto_html(self):
        return self.alumno.foto_html()
    foto_html.short_description = 'Fotografía'

    def edad(self):
        return self.alumno.edad()
    edad.short_description = 'Edad'

    class Meta:
        verbose_name = "Alumn@s por curso"
        unique_together = (("curso", "alumno"),)
        ordering = [ 'curso', 'alumno', ]


@python_2_unicode_compatible
class Tutor(TimeStampedModel):

    dni = models.CharField(unique=True, max_length=15, db_index=True)
    nombre = models.CharField(max_length=100)
    apellidos = models.CharField(max_length=100)
    domicilio = models.CharField(max_length=100, blank=True)
    codigo_postal = models.CharField(max_length=10, blank=True)
    municipio = models.CharField(max_length=50, blank=True)
    provincia = models.CharField(max_length=50, blank=True)
    foto = models.ImageField(upload_to='tutores', blank=True, default='')
    telefono1 = models.CharField(max_length=50, blank=True)
    telefono2 = models.CharField(max_length=50, blank=True)
    email = models.EmailField(max_length=50, blank=True)
    alumnos = models.ManyToManyField(Alumno, blank=True, related_name='tutores')

    def __str__(self):
        return u"{0}, {1}".format(self.apellidos, self.nombre)

    @property
    def get_nombre_completo(self):
        return u"{0}, {1}".format(self.apellidos, self.nombre)

    def foto_html(self, width=48, heigth=48):
        return format_html(
            '<div style="height:{}px;width:{}px;background-repeat:no-repeat;background-position: 50%;'
            'border-radius:50%;background-size:100% auto;background-image:url({})"></div>',
            heigth,
            width,
            self.foto.url if self.foto else static('avatars/nobody.png')
        )
    foto_html.short_description = u'Fotografía del/la tutor/a'
    foto_html.allow_tags = True

    def save(self, *args, **kwargs):
        super(Tutor, self).save(*args, **kwargs)
        if self.foto:
            fit(self.foto.path, settings.MAX_WIDTH, settings.MAX_HEIGHT)

    class Meta:
        verbose_name = "tutor/a"
        verbose_name_plural = "tutores"
        index_together = (("apellidos", "nombre"),)
        ordering = ['apellidos', 'nombre' ]
