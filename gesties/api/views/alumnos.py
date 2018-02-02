# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from rest_framework import generics
from rest_framework.permissions import AllowAny

from gesties.grupos.models import CursoGrupoAlumno
from gesties.libros.models import Libro, Ejemplar, Prestamo
from gesties.api.serializers.alumnos import CursoGrupoAlumnosSerializer
from gesties.api.serializers.libros import LibroSerializer, EjemplarSerializer


# lista de alumnos por grupo
class CursoGrupoAlumnoList(generics.ListAPIView):
    queryset = CursoGrupoAlumno.objects.all()
    serializer_class = CursoGrupoAlumnosSerializer
    filter_fields = ('curso_grupo', )
    permission_classes = (AllowAny, )


# detalle de alumno
class CursoGrupoAlumnoDetail(generics.RetrieveAPIView):
    queryset = CursoGrupoAlumno.objects.all()
    serializer_class = CursoGrupoAlumnosSerializer
    permission_classes = (AllowAny, )


# libros de los cuales el alumno no tiene ningún prestamo
class CursoGrupoAlumnoLibrosPendientesList(generics.ListAPIView):
    serializer_class = LibroSerializer

    def get_queryset(self):
        # tomamos el curso_grupo_alumno
        curso_grupo_alumno = self.request.query_params.get('curso_grupo_alumno')
        qs_curso_grupo_alumno = CursoGrupoAlumno.objects.filter(id=curso_grupo_alumno)
        if qs_curso_grupo_alumno.exists():
            curso_grupo_alumno = qs_curso_grupo_alumno.first()
        qs_libros_prestados_alumno = Libro.objects.filter(ejemplar__prestamo__curso_grupo_alumno=curso_grupo_alumno,
                                                          ejemplar__prestamo__fecha_fin_prestamo__isnull=True)
        qs_libros_grupo = Libro.objects.filter(nivel=curso_grupo_alumno.curso_grupo.grupo.nivel, ejemplar__estado='DISP').distinct()
        qs_libros = qs_libros_grupo.exclude(pk__in=qs_libros_prestados_alumno)
        return qs_libros


# ejemplares que tiene prestados el alumno
class CursoGrupoAlumnoLibrosPrestadosList(generics.ListAPIView):
    serializer_class = EjemplarSerializer

    def get_queryset(self):
        # tomamos el curso_grupo_alumno
        curso_grupo_alumno = self.request.query_params.get('curso_grupo_alumno')
        qs_curso_grupo_alumno = CursoGrupoAlumno.objects.filter(id=curso_grupo_alumno)
        if qs_curso_grupo_alumno.exists():
            curso_grupo_alumno = qs_curso_grupo_alumno.first()
        qs_ejemplares_prestados = Ejemplar.objects.filter(prestamo__curso_grupo_alumno=curso_grupo_alumno,
                                                          prestamo__fecha_fin_prestamo__isnull=True)
        return qs_ejemplares_prestados
