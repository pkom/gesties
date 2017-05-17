# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from rest_framework import generics

from gesties.grupos.models import CursoGrupo
from gesties.api.serializers.grupos import CursoGrupoSerializer


# lista de grupos por curso académico
class CursoGrupoList(generics.ListAPIView):
    queryset = CursoGrupo.objects.all()
    serializer_class = CursoGrupoSerializer
    filter_fields = ('curso', )


# detalle de un grupo
class CursoGrupoDetail(generics.RetrieveAPIView):
    queryset = CursoGrupo.objects.all()
    serializer_class = CursoGrupoSerializer
