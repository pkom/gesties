# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django import forms
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as AuthUserAdmin
from django.contrib.auth.forms import UserChangeForm, UserCreationForm

from gesties.core.admin import CursoEnlaceAdmin, ProfesorEnlaceAdmin

from .models import User, CursoProfesor


class MyUserChangeForm(UserChangeForm):
    class Meta(UserChangeForm.Meta):
        model = User


class MyUserCreationForm(UserCreationForm):

    error_message = UserCreationForm.error_messages.update({
        'duplicate_username': 'Este nombre de usuario/a ya ha sido utilizado.'
    })

    class Meta(UserCreationForm.Meta):
        model = User

    def clean_username(self):
        username = self.cleaned_data["username"]
        try:
            User.objects.get(username=username)
        except User.DoesNotExist:
            return username
        raise forms.ValidationError(self.error_messages['duplicate_username'])


@admin.register(User)
class MyUserAdmin(AuthUserAdmin):
    ordering = ['last_name', 'first_name',]
    form = MyUserChangeForm
    add_form = MyUserCreationForm
    fieldsets = (
            ('User Profile', {'fields': ('name','dni','telefono','usuario_rayuela','es_usuario','id_usuario','foto')}),
    ) + AuthUserAdmin.fieldsets
    list_display = ('username', 'last_name', 'first_name', 'is_superuser', 'foto_html')
    search_fields = ['last_name', 'first_name',]

    class Media:
        css = {
            'all': ('css/admin/mi_admin.css',)
        }


@admin.register(CursoProfesor)
class CursoProfesorAdmin(CursoEnlaceAdmin, ProfesorEnlaceAdmin):
    list_display = ('id', 'curso_link', 'profesor_link', 'foto_html',)
    search_fields = ('profesor__last_name','profesor__first_name',)
    list_filter = ('curso__curso',)
