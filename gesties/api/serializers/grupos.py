# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from rest_framework import serializers

from gesties.grupos.models import Grupo, CursoGrupo
from gesties.api.serializers.users import CursoProfesorSerializer


class GrupoSerializer(serializers.ModelSerializer):

    class Meta:
        model = Grupo
        fields = ('id', 'grupo', 'descripcion', 'slug', 'nivel')


class CursoGrupoSerializer(serializers.ModelSerializer):

    #grupo = GrupoSerializer()
    grupo_desc = serializers.CharField(source='grupo.grupo')
    #tutor = CursoProfesorSerializer()
    #tutor = serializers.StringRelatedField()
    tutor_desc = serializers.CharField(source='tutor.profesor')

    class Meta:
        model = CursoGrupo
        fields = ('id', 'curso', 'grupo', 'grupo_desc', 'tutor', 'tutor_desc')
