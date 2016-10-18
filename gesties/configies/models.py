# -*- coding: utf-8 -*-
from __future__ import unicode_literals, absolute_import

from django.conf import settings
from django.utils.encoding import python_2_unicode_compatible
from django.db import models
from django.utils.html import format_html
from model_utils.models import TimeStampedModel

from gesties.utils.images import fit
from gesties.cursos.models import Curso

@python_2_unicode_compatible
class Configies(TimeStampedModel):
    codigo_centro = models.CharField(unique=True, max_length=15)
    nombre_centro = models.CharField(unique=True, max_length=50)
    url_centro = models.URLField(max_length=200, blank=True)
    email_centro = models.EmailField(max_length=254, blank=True)
    direccion_centro = models.CharField(max_length=200, blank=True)
    telefono_centro = models.CharField(max_length=200, blank=True)
    fax_centro = models.CharField(max_length=200, blank=True)
    curso_defecto = models.ForeignKey(Curso, blank=True, null=True, on_delete=models.SET_NULL)
    nombre_director = models.CharField(max_length=50, blank=True)
    firma_director = models.ImageField(upload_to='configies', blank=True)
    logo_centro = models.ImageField(upload_to='configies', blank=True)
    sello_centro = models.ImageField(upload_to='configies', blank=True)

    def __str__(self):
        return self.nombre_centro

    def firma_director_html(self, width=48, heigth=48):
        return format_html(
            '<div style="height:{}px;width:{}px;background-repeat:no-repeat;background-position: 50%;'
            'border-radius:50%;background-size:100% auto;background-image:url({})"></div>',
            heigth,
            width,
            self.firma_director.url if self.firma_director else None,
        )
    firma_director_html.short_description = u'Firma del/la Director/a'
    firma_director_html.allow_tags = True

    def logo_centro_html(self, width=48, heigth=48):
        return format_html(
            '<div style="height:{}px;width:{}px;background-repeat:no-repeat;background-position: 50%;'
            'border-radius:50%;background-size:100% auto;background-image:url({})"></div>',
            heigth,
            width,
            self.logo_centro.url if self.logo_centro else None,
        )
    logo_centro_html.short_description = u'Logotipo del centro'
    logo_centro_html.allow_tags = True

    def sello_centro_html(self, width=48, heigth=48):
        return format_html(
            '<div style="height:{}px;width:{}px;background-repeat:no-repeat;background-position: 50%;'
            'border-radius:50%;background-size:100% auto;background-image:url({})"></div>',
            heigth,
            width,
            self.sello_centro.url if self.sello_centro else None,
        )
    sello_centro_html.short_description = u'Sello del centro'
    sello_centro_html.allow_tags = True

    def save(self, *args, **kwargs):
        super(Configies, self).save(*args, **kwargs)
        #if self.firma_director:
        #    fit(self.firma_director.path, settings.MAX_WIDTH, settings.MAX_HEIGHT)
        #if self.logo_centro:
        #    fit(self.logo_centro.path, settings.MAX_WIDTH, settings.MAX_HEIGHT)
        #if self.sello_centro:
        #    fit(self.sello_centro.path, settings.MAX_WIDTH, settings.MAX_HEIGHT)

    class Meta:
        verbose_name = 'configies'
        verbose_name_plural = 'configies'
        ordering = ['nombre_centro']
