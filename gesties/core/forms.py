# -*- coding: utf-8 -*-

from django import forms
from django.urls import reverse


class TraspasoForm(forms.Form):
    curso_origen = forms.ChoiceField(label='Curso Origen')
    curso_destino = forms.ChoiceField(label='Curso Destino')
    curso_grupo_origen = forms.ChoiceField(label='Grupo Origen')
    curso_grupo_destino = forms.ChoiceField(label='Grupo Destino')
    curso_grupo_alumno_origen = forms.MultipleChoiceField(label='Alumno/as Origen')
    curso_grupo_alumno_destino = forms.MultipleChoiceField(label='Alumno/as Destino')

    def __init__(self, *args, **kwargs):
        super(TraspasoForm, self).__init__(*args, **kwargs)
        self.fields['curso_origen'].widget = forms.Select({
            'class': 'form-control',
            'data-url': reverse('api:cursos-list'),
            'data-placeholder': 'Elige un curso de Origen...',
        })
        self.fields['curso_grupo_origen'].widget = forms.Select({
            'class': 'form-control',
            'data-url': reverse('api:grupos-list'),
            'data-placeholder': 'Elige un grupo de Origen...'
        })
        self.fields['curso_grupo_alumno_origen'].widget = forms.Select({
            'class': 'form-control',
            'data-url': reverse('api:alumnos-grupo-list'),
            'data-placeholder': 'Elige alumno/as a Traspasar...',
            'multiple': 'multiple'
        })
        self.fields['curso_destino'].widget = forms.Select({
            'class': 'form-control',
            'data-url': reverse('api:cursos-list'),
            'data-placeholder': 'Elige un curso de Destino...',
        })
        self.fields['curso_grupo_destino'].widget = forms.Select({
            'class': 'form-control',
            'data-url': reverse('api:grupos-list'),
            'data-placeholder': 'Elige un grupo de Destino...',
        })
        self.fields['curso_grupo_alumno_destino'].widget = forms.Select({
            'class': 'form-control',
            'data-url': reverse('api:alumnos-grupo-list'),
            'data-placeholder': 'Elige alumno/as a Desasignar...',
            'multiple': 'multiple'
        })
