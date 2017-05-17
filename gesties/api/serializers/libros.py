# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from rest_framework import serializers

from gesties.libros.models import Libro, Ejemplar, Prestamo


class LibroSerializer(serializers.ModelSerializer):

    class Meta:
        model = Libro
        fields = ('id', 'titulo', 'autor', 'editorial', 'anio_edicion', 'area_conocimiento',
                  'isbn', 'codigo_barras', 'nivel', 'numero_ejemplares', 'bajas', 'precio',
                  'fecha_inicio', 'fecha_fin'
                  )


class EjemplarSerializer(serializers.ModelSerializer):

    libro = serializers.StringRelatedField()

    class Meta:
        model = Ejemplar
        fields = ('id', 'libro', 'estado', 'codigo_barras')


class PrestamoSerializer(serializers.ModelSerializer):

    class Meta:
        model = Prestamo
        fields = ('id', 'ejemplar', 'curso_grupo_alumno', 'fecha_inicio_prestamo', 'fecha_fin_prestamo',
                  'user', 'user_devolucion')
