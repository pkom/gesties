# -*- coding: utf-8 -*-
from __future__ import unicode_literals, absolute_import

import jwt
from datetime import datetime, timedelta

from django.conf import settings
from django.contrib.auth.models import AbstractUser
from django.core.urlresolvers import reverse
from django.db import models
from django.utils.encoding import python_2_unicode_compatible
from django.utils.html import format_html
from django.contrib.staticfiles.templatetags.staticfiles import static
from django.contrib.auth.signals import user_logged_in

from model_utils.models import TimeStampedModel

from gesties.cursos.models import Curso


from gesties.core.images import fit
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


def do_login(sender, user, request, **kwargs):
    print("Usuario " + user.username + " ha iniciado sesión")

# Activar signal para ejecutar algo cada vez que se hace login
#user_logged_in.connect(do_login)


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
    telefono = models.CharField('Teléfonos', help_text='Teléfonos de contacto', blank=True, max_length=50)

    def __str__(self):
        return u'{0}, {1}'.format(self.last_name, self.first_name)

    def get_absolute_url(self):
        return reverse('users:detail', kwargs={'username': self.username})

    @property
    def get_nombre_completo(self):
        return u"{0}, {1}".format(self.last_name, self.first_name)

    @property
    def token(self):
        """
        Allows us to get a user's token by calling `user.token` instead of
        `user.generate_jwt_token().

        The `@property` decorator above makes this possible. `token` is called
        a "dynamic property".
        """
        return self._generate_jwt_token()

    def foto_html(self, width=48, heigth=48):
        return format_html(
            '<div style="height:{}px;width:{}px;background-repeat:no-repeat;background-position: 50%;'
            'border-radius:50%;background-size:100% auto;background-image:url({})"></div>',
            heigth,
            width,
            self.foto.url if self.foto else static('avatars/nobody.png'),
        )
    foto_html.short_description = u'Fotografía'

    def _generate_jwt_token(self):
        """
        Generates a JSON Web Token that stores this user's ID and has an expiry
        date set to 60 days into the future.
        """
        dt = datetime.now() + timedelta(days=60)

        token = jwt.encode({
            'id': self.pk,
            'exp': int(dt.strftime('%s'))
        }, settings.SECRET_KEY, algorithm='HS256')
        return token.decode('utf-8')

#    def save(self, *args, **kwargs):
#        super(User, self).save(*args, **kwargs)
#        if self.foto:
#            fit(self.foto.path, settings.MAX_WIDTH, settings.MAX_HEIGHT)

    class Meta:
        verbose_name = 'usuari@'
        verbose_name_plural = 'usuari@s'
        ordering = ['last_name', 'first_name']


@python_2_unicode_compatible
class CursoProfesor(TimeStampedModel):

    curso = models.ForeignKey(Curso, on_delete=models.CASCADE,
                              related_name='profesores')
    profesor = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE,
                                 related_name='cursos')

    def __str__(self):
        return u"{0} - {1} ".format(self.curso, self.profesor)

    def foto_html(self):
        return self.profesor.foto_html()
    foto_html.short_description = u'Fotografía'

    class Meta:
        verbose_name = "Usuari@s por curso"
        unique_together = (("curso", "profesor"),)
        ordering = [ 'curso', 'profesor', ]
