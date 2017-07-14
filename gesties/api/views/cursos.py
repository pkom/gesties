# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from rest_framework import generics
from rest_framework.permissions import AllowAny

from gesties.cursos.models import Curso
from gesties.api.serializers.cursos import CursoSerializer


# lista de cursos académicos
class CursoList(generics.ListAPIView):
    permission_classes = [AllowAny, ]
    queryset = Curso.objects.all()
    serializer_class = CursoSerializer
