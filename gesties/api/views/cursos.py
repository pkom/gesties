# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from rest_framework import generics

from gesties.cursos.models import Curso
from gesties.api.serializers.cursos import CursoSerializer


# lista de cursos académicos
class CursoList(generics.ListAPIView):
    queryset = Curso.objects.all()
    serializer_class = CursoSerializer
