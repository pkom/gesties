# -*- coding: utf-8 -*-
from __future__ import unicode_literals, absolute_import

from PIL import Image

from django.conf import settings
from django.contrib.auth.models import AbstractUser
from django.core.urlresolvers import reverse
from django.db import models
from django.utils.encoding import python_2_unicode_compatible
from django.utils.html import format_html
from django.contrib.staticfiles.templatetags.staticfiles import static
#from django_auth_ldap.backend import populate_user


# no funciona AUTH_PROFILE_MODULE actualizamos datos mediante este signal
#def update_user(sender, user=None, ldap_user=None, **kwargs):

    # Remember that every attribute maps to a list of values
#    dni = ldap_user.attrs.get("employeeNumber", [])
#    uid = ldap_user.attrs.get("uid", [])
#    if dni:
#        user.dni = dni[0]
#    if uid:
#        user.usuario_rayuela = uid[0]
#    user.save()

#populate_user.connect(update_user)

# para reducir imágenes
def fit(file_path, max_width=None, max_height=None, save_as=None):
    # Open file
    img = Image.open(file_path)

    # Store original image width and height
    w, h = img.size

    # Replace width and height by the maximum values
    w = int(max_width or w)
    h = int(max_height or h)

    # Proportinally resize
    img.thumbnail((w, h), Image.ANTIALIAS)

    # Save in (optional) 'save_as' or in the original path
    img.save(save_as or file_path)

    return True


def upload_to(instance, filename):
    return '/'.join(['usuarios', instance.username, filename])

@python_2_unicode_compatible
class User(AbstractUser):

    # First Name and Last Name do not cover name patterns
    # around the globe.
    name = models.CharField('Nombre completo del usuario/a', blank=True, max_length=255)
    dni = models.CharField('D.N.I.', help_text='Número del DNI', blank=True, max_length=20, db_index=True)
    usuario_rayuela = models.CharField('Usuario/a Rayuela', help_text='Usuario Rayuela', blank=True, max_length=50)
    foto = models.ImageField('Fotografía', help_text='Fotografía del usuario/a', upload_to=upload_to, blank=True)
    es_usuario = models.BooleanField('¿Es usuario/a de rayuela?', help_text='¿Es usuario/a de Rayuela', default=False)
    id_usuario = models.CharField('ID Rayuela', help_text='ID Rayuela', blank=True, max_length=20)

    def __str__(self):
        return self.username

    def get_absolute_url(self):
        return reverse('users:detail', kwargs={'username': self.username})

    def foto_html(self, width=48, heigth=48):
        return format_html(
            '<div style="height:{}px;width:{}px;background-repeat:no-repeat;background-position: 50%;'
            'border-radius:50%;background-size:100% auto;background-image:url({})"></div>',
            heigth,
            width,
            self.foto.url if self.foto else static('avatars/nobody.png'),
        )
    foto_html.short_description = u'Fotografía'

    def save(self, *args, **kwargs):
        super(User, self).save(*args, **kwargs)
        if self.foto:
            fit(self.foto.path, settings.MAX_WIDTH, settings.MAX_HEIGHT)
