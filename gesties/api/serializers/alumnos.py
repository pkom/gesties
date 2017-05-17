# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from rest_framework import serializers


from gesties.api.serializers.grupos import CursoGrupoSerializer
from gesties.alumnos.models import Alumno, CursoAlumno
from gesties.grupos.models import CursoGrupoAlumno


class AlumnoSerializer(serializers.ModelSerializer):

    class Meta:
        model = Alumno
        fields = ('id', 'nie', 'get_nombre_completo')


class CursoAlumnoSerializer(serializers.ModelSerializer):

    alumno = AlumnoSerializer()

    class Meta:
        model = CursoAlumno
        fields = ('id', 'curso', 'alumno')


class CursoGrupoAlumnosSerializer(serializers.ModelSerializer):

    #curso_grupo = CursoGrupoSerializer()
    #curso_alumno = CursoAlumnoSerializer()
    grupo = serializers.CharField(source='curso_grupo.grupo.grupo')
    alumno = serializers.CharField(source='curso_alumno.alumno')

    class Meta:
        model = CursoGrupoAlumno
        fields = ('id', 'curso_grupo', 'grupo', 'curso_alumno', 'alumno')
