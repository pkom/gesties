# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from PIL import Image

from django import forms
from django.contrib.auth.forms import AuthenticationForm

from gesties.cursos.models import Curso

from .models import CursoProfesor, User


class AutenticacionForm(AuthenticationForm):

    # username = forms.CharField(required=True,
    #     widget=forms.TextInput(attrs={'autofocus': '', 'class':'form-control', 'placeholder':'Usuario/a'}),
    # )
    # password = forms.CharField(
    #     strip=False,
    #     widget=forms.PasswordInput(attrs={'class':'form-control', 'placeholder':'Contraseña'}),
    # )
    curso_academico = forms.ModelChoiceField(required=True, queryset=Curso.objects.all(),
        initial={},
        widget=forms.Select(attrs={'class':'form-control'})
    )

    def __init__(self, *args, **kwargs):
        super(AutenticacionForm, self).__init__(*args, **kwargs)
        self.fields["username"].required = True
        self.fields["username"].widget = forms.TextInput(attrs={'autofocus': '', 'class':'form-control', 'placeholder':'Usuario/a'})
        self.fields["password"].strip = False
        self.fields["password"].widget = forms.PasswordInput(attrs={'class':'form-control', 'placeholder':'Contraseña'})

    def confirm_login_allowed(self, user):
        """
        Controls whether the given User may log in. This is a policy setting,
        independent of end-user authentication. This default behavior is to
        allow login by active users, and reject login by inactive users.

        If the given user cannot log in, this method should raise a
        ``forms.ValidationError``.

        If the given user may log in, this method should return None.
        """
        if not user.is_active:
            raise forms.ValidationError(
                self.error_messages['inactive'],
                code='inactive',
            )
        # comprobemos que este usuario está asignado al curso actual y que no pertenezca al grupo responsables, administrativos
        if not (user.groups.filter(name='responsables').exists() or user.groups.filter(name='administrativos').exists()):
            # veamos si tiene asignado un departamento
            cursoprofesor = CursoProfesor.objects.filter(profesor=user,
                                                                 curso__curso=self.cleaned_data["curso_academico"])
            if not cursoprofesor:
                raise forms.ValidationError("Est@ usuari@ no está dado de alta en el curso seleccionado",
                                code='no_existe_en_curso')


class UserForm(forms.ModelForm):

    x = forms.FloatField(widget=forms.HiddenInput())
    y = forms.FloatField(widget=forms.HiddenInput())
    width = forms.FloatField(widget=forms.HiddenInput())
    height = forms.FloatField(widget=forms.HiddenInput())

    class Meta:
        model = User
        fields = ('name', 'foto', 'x', 'y', 'width', 'height', )
        widgets = {
            'foto': forms.FileInput(attrs={
                'accept': 'image/*'  # this is not an actual validation! don't rely on that!
            })
        }

    def save(self):
        user = super(UserForm, self).save()

        x = self.cleaned_data.get('x')
        y = self.cleaned_data.get('y')
        w = self.cleaned_data.get('width')
        h = self.cleaned_data.get('height')

        image = Image.open(user.foto)
        cropped_image = image.crop((x, y, w+x, h+y))
        resized_image = cropped_image.resize((48, 48), Image.ANTIALIAS)
        resized_image.save(user.foto.path)

        return user


class UserFotoForm(forms.ModelForm):

    x = forms.FloatField(widget=forms.HiddenInput())
    y = forms.FloatField(widget=forms.HiddenInput())
    width = forms.FloatField(widget=forms.HiddenInput())
    height = forms.FloatField(widget=forms.HiddenInput())

    class Meta:

        model = User
        fields = ('foto', 'x', 'y', 'width', 'height', )


    def save(self):

        user = super(UserFotoForm, self).save()

        x = self.cleaned_data.get('x')
        y = self.cleaned_data.get('y')
        w = self.cleaned_data.get('width')
        h = self.cleaned_data.get('height')

        image = Image.open(user.foto)
        cropped_image = image.crop((x, y, w+x, h+y))
        resized_image = cropped_image.resize((200, 200), Image.ANTIALIAS)
        resized_image.save(user.foto.path)

        return user
