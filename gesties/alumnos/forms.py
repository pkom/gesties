# -*- coding: utf-8 -*-

from django import forms
from .models import Alumno

class AlumnoForm(forms.ModelForm):
    class Meta:
        model = Alumno
        fields = ('nie', 'nombre', 'apellidos', 'dni', 'direccion', 'codigo_postal',
                  'localidad', 'provincia', 'fecha_nacimiento', 'usuario_rayuela',
                  'foto', 'telefono', 'email', 'expediente', )
