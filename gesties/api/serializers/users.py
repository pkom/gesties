# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from rest_framework import serializers

from gesties.users.models import User, CursoProfesor


class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = ('id', 'get_nombre_completo')


class CursoProfesorSerializer(serializers.ModelSerializer):

    profesor = UserSerializer()

    class Meta:
        model = CursoProfesor
        fields = ('id', 'curso', 'profesor')
