# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.core.exceptions import ObjectDoesNotExist
from django.utils import timezone

from rest_framework import status
from rest_framework import generics
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response

from gesties.grupos.models import CursoGrupoAlumno
from gesties.libros.models import Libro, Ejemplar, Prestamo
from gesties.api.serializers.libros import EjemplarSerializer
from gesties.api.permissions import IsResponsableOrAdministrativo


# lista del ejemplares disponibles de un libro
class LibroEjemplaresDisponiblesList(generics.ListAPIView):
    serializer_class = EjemplarSerializer

    def get_queryset(self):
        # tomamos el libro
        libro = self.request.query_params.get('libro')
        qs_libro = Libro.objects.filter(id=libro)
        if qs_libro.exists():
            libro = qs_libro.first()
        qs_ejemplares = Ejemplar.objects.filter(libro=libro, estado='DISP')
        return qs_ejemplares


# vista para préstamo de libro
@api_view(['POST'])
@permission_classes((IsResponsableOrAdministrativo, ))
def EjemplarLibroAlumnoPrestar(request):

    if request.method == 'POST':
        # vamos a localizar el Ejemplar sobre el que estamos prestando,
        # tenemos en request.data --> {'curso_grupo_alumno': xxx, 'id_ejemplar': xxx,
        # 'codigo_barras': xxx }
        datos = request.data
        id_ejemplar = datos.get('id_ejemplar', None)
        id_curso_grupo_alumno = datos.get('curso_grupo_alumno', None)
        codigo_barras = datos.get('codigo_barras', None)
        # comprobaciones
        # 1º los parámetros necesarios están pasados
        if id_curso_grupo_alumno is '' and (id_ejemplar is not '' or codigo_barras is not ''):
            return Response({'status': 'ERR', 'message': u'No se han pasado los parámetros necesarios'}, status=status.HTTP_200_OK)

        try:
            if id_ejemplar is not '':
                ejemplar = Ejemplar.objects.get(id=id_ejemplar)
            else:
                ejemplar = Ejemplar.objects.get(codigo_barras=codigo_barras)

        except ObjectDoesNotExist:
            return Response({'status': 'ERR', 'message': u'El ejemplar no existe'}, status=status.HTTP_200_OK)

        # 2º que el ejemplar esté disponible y el alumno tambien exista
        if not ejemplar.estado == 'DISP':
            return Response({'status': 'ERR', 'message': u'El ejemplar no está disponible'}, status=status.HTTP_200_OK)
        try:
            curso_grupo_alumno = CursoGrupoAlumno.objects.get(id=id_curso_grupo_alumno)
        except ObjectDoesNotExist:
            return Response({'status': 'ERR', 'message': u'El alumno/a no existe'}, status=status.HTTP_200_OK)
        # 3º que el alumno no tenga ya un ejemplar del libro prestado o lo tenga ya prestado
        if Prestamo.objects.filter(ejemplar__libro=ejemplar.libro, curso_grupo_alumno=curso_grupo_alumno, fecha_fin_prestamo__isnull=True).exists():
            return Response({'status': 'ERR', 'message': u'El alumno/a ya tiene un ejemplar de ese libro'}, status=status.HTTP_200_OK)
        # 4º que el ejemplar no esté asignado a otro alumno
        if Prestamo.objects.filter(ejemplar=ejemplar, fecha_fin_prestamo__isnull=True).exists():
            return Response({'status': 'ERR', 'message': u'El ejemplar ya está prestado a otro alumno/a'}, status=status.HTTP_200_OK)
        # 5º que el ejemplar pertenezca a un libro del nivel del alumno
        if not curso_grupo_alumno.curso_grupo.grupo.nivel == ejemplar.libro.nivel:
            return Response({'status': 'ERR', 'message': u'El ejemplar no pertenece al nivel del alumno/a'}, status=status.HTTP_200_OK)
        # CORRECTO
        ejemplar.estado = 'PRES'
        ejemplar.save()
        prestamo = Prestamo(ejemplar=ejemplar, curso_grupo_alumno=curso_grupo_alumno, user=request.user)
        prestamo.save()
        #serializer = EjemplarSerializer(ejemplar)
        #return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response({'status': 'OK', 'message': u'Se ha realizado el préstamo'}, status=status.HTTP_201_CREATED)


# vista para devolución de libro
@api_view(['POST'])
@permission_classes((IsResponsableOrAdministrativo, ))
def EjemplarLibroAlumnoDevolver(request):

    if request.method == 'POST':
        # vamos a localizar el Ejemplar sobre el que estamos devolviendo
        # tenemos en request.data --> {'curso_grupo_alumno': xxx, 'id_ejemplar': xxx }
        # como vienen de un select multiple los ejemplares vienen en un array,
        # convertimos a un diccionario estándar de python
        datos = dict(request.data)
        id_ejemplares = datos.get('id_ejemplares[]', None)
        id_curso_grupo_alumno = datos.get('curso_grupo_alumno', None)
        codigo_barras = datos.get('codigo_barras', None)
        if id_curso_grupo_alumno is '' and (id_ejemplares or codigo_barras is not ''):
            return Response({'status': 'ERR', 'message': u'No se han pasado los parámetros necesarios'}, status=status.HTTP_200_OK)
        if not id_ejemplares and codigo_barras is not '':
            # tenemos codigo de barras pero no id_ejemplares
            try:
                ejemplar = Ejemplar.objects.get(codigo_barras=codigo_barras[0])
            except ObjectDoesNotExist:
                return Response({'status': 'ERR', 'message': u'El ejemplar no existe'}, status=status.HTTP_200_OK)
            id_ejemplares = [ ejemplar.id ]

        for id_ejemplar in id_ejemplares:
            # comprobaciones
            # 1º los parámetros están pasados
            if id_ejemplar is None or id_curso_grupo_alumno is None:
                return Response({'status': 'ERR', 'message': u'No se han pasado parámetros'}, status=status.HTTP_400_BAD_REQUEST)
            # 2º que el ejemplar exista, esté disponible y el alumno tambien exista
            try:
                ejemplar = Ejemplar.objects.get(id=id_ejemplar)
            except ObjectDoesNotExist:
                return Response({'status': 'ERR', 'message': u'El ejemplar no existe'}, status=status.HTTP_404_NOT_FOUND)
            if not ejemplar.estado == 'PRES':
                return Response({'status': 'ERR', 'message': u'El ejemplar no está prestado'}, status=status.HTTP_400_BAD_REQUEST)
            try:
                curso_grupo_alumno = CursoGrupoAlumno.objects.get(id=id_curso_grupo_alumno[0])
            except ObjectDoesNotExist:
                return Response({'status': 'ERR', 'message': u'El alumno/a no existe'}, status=status.HTTP_404_NOT_FOUND)
            # 3º que el alumno tenga ya ese ejemplar del libro prestado
            qs_prestamo = Prestamo.objects.filter(ejemplar__libro=ejemplar.libro, curso_grupo_alumno=curso_grupo_alumno, fecha_fin_prestamo__isnull=True)
            if not qs_prestamo.exists():
                return Response({'status': 'ERR', 'message': u'El alumno/a no tiene ese ejemplar prestado'}, status=status.HTTP_400_BAD_REQUEST)
            prestamo = qs_prestamo.first()
            # 4º que el ejemplar pertenezca a un libro del nivel del alumno
            if not curso_grupo_alumno.curso_grupo.grupo.nivel == ejemplar.libro.nivel:
                return Response({'status': 'ERR', 'message': u'El ejemplar no pertenece al nivel del alumno/a'}, status=status.HTTP_400_BAD_REQUEST)
            # CORRECTO
            ejemplar.estado = 'DISP'
            ejemplar.save()
            prestamo.user_devolucion = request.user
            prestamo.fecha_fin_prestamo = timezone.now()
            prestamo.save()
            #serializer = EjemplarSerializer(ejemplar)
            #return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response({'status': 'OK', 'message': u'Se ha realizado la devolución'}, status=status.HTTP_201_CREATED)
