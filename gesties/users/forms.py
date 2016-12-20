# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django import forms
from django.contrib.auth.forms import AuthenticationForm

from gesties.cursos.models import Curso
from gesties.departamentos.models import CursoDepartamentoProfesor
from gesties.configies.models import Configies


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
        # comprobemos que este usuario está asignado al curso actual y que no pertenezca al grupo responsables
        if not user.groups.filter(name='responsables').exists():
            # veamos si tiene asignado un departamento
            cursodepartamentoprofesor = CursoDepartamentoProfesor.objects.filter(profesor=user,
                                                                 curso_departamento__curso=self.cleaned_data["curso_academico"])
            if not cursodepartamentoprofesor:
                raise forms.ValidationError("Este usuario/a no pertenece a ningún departamento en el curso seleccionado",
                                code='no_existe_en_curso')

