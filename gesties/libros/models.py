# -*- coding: utf-8 -*-
from __future__ import unicode_literals, absolute_import

from django.utils.encoding import python_2_unicode_compatible
from django.db import models
from django.conf import settings

from model_utils.models import TimeStampedModel

from gesties.configies.models import Configies
from gesties.grupos.models import CursoGrupoAlumno


@python_2_unicode_compatible
class Autor(TimeStampedModel):

    autor = models.CharField('Autor', help_text='Nombre del autor/es', max_length=150)

    def __str__(self):
        return u"{0}".format(self.autor)

    class Meta:
        verbose_name_plural = "Autores"
        ordering = ['autor' ]


@python_2_unicode_compatible
class Editorial(TimeStampedModel):

    editorial = models.CharField('Editorial', help_text='Nombre de la editorial', max_length=150)

    def __str__(self):
        return u"{0}".format(self.editorial)

    class Meta:
        verbose_name_plural = "Editoriales"
        ordering = ['editorial' ]


@python_2_unicode_compatible
class Area(TimeStampedModel):

    area = models.CharField('Área', help_text='Área de conocimiento', max_length=150)

    def __str__(self):
        return u"{0}".format(self.area)

    class Meta:
        ordering = ['area' ]


@python_2_unicode_compatible
class Ciclo(TimeStampedModel):

    ciclo = models.CharField('Ciclo', help_text='Ciclo de estudios', max_length=50)
    descripcion = models.CharField(blank=True, max_length=150)

    def __str__(self):
        return u"{0} - {1}".format(self.ciclo, self.descripcion)

    class Meta:
        ordering = ['ciclo' ]


@python_2_unicode_compatible
class Nivel(TimeStampedModel):

    ciclo = models.ForeignKey(Ciclo, on_delete=models.SET_NULL, null=True)
    nivel = models.SmallIntegerField('Nivel')

    def __str__(self):
        return u"{0} - {1}".format(self.nivel, self.ciclo)

    class Meta:
        verbose_name_plural = "Niveles"
        ordering = ['nivel' ]


@python_2_unicode_compatible
class Libro(TimeStampedModel):

    titulo = models.CharField('Título', help_text="Título del libro", max_length=150, db_index=True)
    autor = models.ForeignKey(Autor, on_delete=models.SET_NULL, null=True, blank=True)
    editorial = models.ForeignKey(Editorial, on_delete=models.SET_NULL, null=True, blank=True)
    anio_edicion = models.CharField('Año Edición', help_text='Año de la edición', blank=True, max_length=4)
    area_conocimiento = models.ForeignKey(Area, on_delete=models.SET_NULL, null=True, blank=True)
    isbn = models.CharField('ISBN', blank=True, max_length=50)
    codigo_barras = models.CharField('Código de barras', max_length=50, unique=True, blank=True, db_index=True)
    nivel = models.ForeignKey(Nivel, on_delete=models.SET_NULL, null=True, blank=True)
    numero_ejemplares = models.SmallIntegerField('Número de Ejemplares', default=1)
#    bajas = models.SmallIntegerField('Número de Ejemplares dados de baja', default=0)
    precio = models.DecimalField('Precio del libro', max_digits=6, decimal_places=2, blank=True, null=True )
    fecha_inicio = models.DateField(blank=True, null=True)
    fecha_fin = models.DateField(blank=True, null=True)

    def __str__(self):

        return u"{0}".format(self.titulo)

    @property
    def bajas(self):
        return self.ejemplar_set.filter(estado=Ejemplar.BAJA).count()

    @property
    def prestados(self):
        return self.ejemplar_set.filter(estado=Ejemplar.PRESTADO).count()

    @property
    def disponibles(self):
        return self.ejemplar_set.filter(estado=Ejemplar.DISPONIBLE).count()

    @property
    def deteriorados(self):
        return self.ejemplar_set.filter(estado=Ejemplar.DETERIORADO).count()

    #tenemos que generar un código de barras si no tiene ese dato
    def save(self, *args, **kwargs):

        if not self.codigo_barras:
            centro = Configies.objects.all().first().codigo_centro
            num_libros = Libro.objects.count() or 0
            num_libros += 1
            codigo_barras = "{0}{1:04}".format(centro, num_libros)
            while Libro.objects.filter(codigo_barras=codigo_barras).exists():
                num_libros += 1
                codigo_barras = "{0}{1:04}".format(centro, num_libros)

            self.codigo_barras = codigo_barras
        # comprobaremos y crearemos los ejemplares que no existan
        if not self.pk:
            super(Libro, self).save(*args, **kwargs)

        num_ejemplares = self.numero_ejemplares
        qs_libro_ejemplares = self.ejemplar_set.all()
        num_ejemplares_creados = qs_libro_ejemplares.count()
        num_ejemplares_a_crear = num_ejemplares - num_ejemplares_creados
        if num_ejemplares_a_crear > 0:
            faltan = range(num_ejemplares_a_crear)
            for i in faltan:
                self.ejemplar_set.create(libro=self, estado=Ejemplar.DISPONIBLE)
        self.numero_ejemplares = qs_libro_ejemplares.count()
        super(Libro, self).save(*args, **kwargs)

    class Meta:
        verbose_name = "libro"
        verbose_name_plural = "libros"
        ordering = ['titulo' ]


@python_2_unicode_compatible
class Ejemplar(TimeStampedModel):

    DISPONIBLE = 'DISP'
    PRESTADO = 'PRES'
    DETERIORADO = 'DETE'
    BAJA = 'BAJA'
    ESTADO_EJEMPLAR_CHOICES = (
        (DISPONIBLE, 'Disponible'),
        (PRESTADO, 'Prestado'),
        (DETERIORADO, 'Deteriorado'),
        (BAJA, 'Dado de baja'),
    )

    libro = models.ForeignKey(Libro, on_delete=models.CASCADE)
    estado = models.CharField(
        db_index=True,
        max_length=4,
        choices=ESTADO_EJEMPLAR_CHOICES,
        default=DISPONIBLE,
    )
    codigo_barras = models.CharField('Código de barras', max_length=50, unique=True, blank=True, db_index=True)

    def __str__(self):
        return u"{0}, {1}-({2})".format(self.libro, self.estado, self.codigo_barras)

    @property
    def alumno(self):
        alumno = self.prestamo_set.filter(fecha_fin_prestamo__isnull=True).first()
        if alumno:
            return "({}) {}".format(alumno.curso_grupo_alumno.curso_grupo.grupo, alumno.curso_grupo_alumno.curso_alumno.alumno)
        return u"Sin préstamo a alumn@"

    def save(self, *args, **kwargs):

        if not self.codigo_barras:
            num_ejemplares = self.libro.ejemplar_set.all().count() or 0
            num_ejemplares += 1
            self.codigo_barras = "{0}{1:04}".format(self.libro.codigo_barras, num_ejemplares)

        super(Ejemplar, self).save(*args, **kwargs)

    class Meta:

        verbose_name = "ejemplar"
        verbose_name_plural = "ejemplares"
        ordering = ("codigo_barras", )

@python_2_unicode_compatible
class Prestamo(TimeStampedModel):

    ejemplar = models.ForeignKey(Ejemplar, on_delete=models.CASCADE)
    curso_grupo_alumno = models.ForeignKey(CursoGrupoAlumno, on_delete=models.CASCADE)
    fecha_inicio_prestamo = models.DateTimeField(auto_now_add=True, blank=True)
    fecha_fin_prestamo = models.DateTimeField(blank=True, null=True, db_index=True)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    user_devolucion = models.ForeignKey(settings.AUTH_USER_MODEL, related_name='user_dev',
                                        on_delete=models.CASCADE, blank=True, null=True)

    def __str__(self):

        return u"{0} - {1} - Prestado: {2} Devuelto: {3}".format(self.ejemplar, self.curso_grupo_alumno.curso_alumno.alumno,
                                         self.fecha_inicio_prestamo.strftime("%Y-%m-%d %H:%M"),
                                         self.fecha_fin_prestamo.strftime("%Y-%m-%d %H:%M") if self.fecha_fin_prestamo else "")

    class Meta:

        verbose_name = "préstamo"
        verbose_name_plural = "préstamos"
