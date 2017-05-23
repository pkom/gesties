# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.http import JsonResponse
from django.views.generic import View

from braces.views import LoginRequiredMixin, GroupRequiredMixin, AjaxResponseMixin
from rest_framework import generics

from gesties.alumnos.models import CursoAlumno
from gesties.cursos.models import Curso
from gesties.grupos.models import CursoGrupo, CursoGrupoAlumno
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

# crear grupo desde formulario de traspasos
class CursoGrupoCreate(LoginRequiredMixin, GroupRequiredMixin, AjaxResponseMixin, View):

    group_required = ['informaticos']

    def post(self, *args, **kwargs):
        # en self.request.POST tenemos curso_destino y curso_grupo_origen
        # tenemos que comprobar que no exista un grupo en destino con la misma descripción
        curso_destino = self.request.POST.get('curso_destino')
        curso_grupo_origen = self.request.POST.get('curso_grupo_origen')
        data = dict()
        qs_curso_grupo_origen = CursoGrupo.objects.filter(pk=curso_grupo_origen)
        if not qs_curso_grupo_origen.exists():
            data['status'] = 'ERR'
            data['error'] = "No existe el grupo que queremos crear en el curso origen"
            return JsonResponse(data)
        curso_grupo_origen = qs_curso_grupo_origen.first()
        grupo = curso_grupo_origen.grupo
        qs_curso_destino = Curso.objects.filter(pk=curso_destino)
        if not qs_curso_destino.exists():
            data['status'] = 'ERR'
            data['error'] = "No existe el curso donde se va a crear el grupo"
            return JsonResponse(data)
        curso_destino = qs_curso_destino.first()
        grupo_desc = curso_grupo_origen.grupo.grupo
        # comprobemos que no hay un grupo en el curso destino que tenga la misma descripción
        if CursoGrupo.objects.filter(curso=curso_destino, grupo__grupo=grupo_desc).exists():
            data['status'] = 'ERR'
            data['error'] = "Ya existe el grupo {} en el curso destino".format(grupo_desc)
            return JsonResponse(data)
        nuevo_curso_grupo = CursoGrupo(curso=curso_destino, grupo=grupo)
        nuevo_curso_grupo.save()
        data['status'] = 'OK'
        return JsonResponse(data)


# crear alumnos en grupo destino desde formulario de traspasos
class CursoGrupoCreateAlumnos(LoginRequiredMixin, GroupRequiredMixin, AjaxResponseMixin, View):

    group_required = ['informaticos']

    def post(self, *args, **kwargs):
        # en self.request.POST tenemos curso_grupo_destino y lista_alumnos_a_crear
        # tenemos que comprobar que no exista un grupo en destino con la misma descripción
        curso_grupo_destino = self.request.POST.get('curso_grupo_destino')
        lista_alumnos_a_crear = self.request.POST.getlist('lista_alumnos_a_crear[]')
        data = dict()
        qs_curso_grupo_destino = CursoGrupo.objects.filter(pk=curso_grupo_destino)
        if not qs_curso_grupo_destino.exists():
            data['status'] = 'ERR'
            data['error'] = "No existe el grupo al que queremos pasar los alumno/as en el curso destino"
            return JsonResponse(data)
        curso_grupo_destino = qs_curso_grupo_destino.first()
        # en la lista están los ids de alumnos del curso de origen
        for id_curso_grupo_alumno_origen in lista_alumnos_a_crear:
            curso_grupo_alumno_origen = CursoGrupoAlumno.objects.filter(pk=id_curso_grupo_alumno_origen).first()
            if curso_grupo_alumno_origen:
                alumno = curso_grupo_alumno_origen.curso_alumno.alumno
                # creamos entrada para el alumno en el curso
                # primero buscamos que no exista el alumno en el curso destino y si no existe crea una entrada en el curso
                curso_alumno_destino, created = CursoAlumno.objects.get_or_create(curso=curso_grupo_destino.curso,alumno=alumno)
                # ahora debemos crear la entrada para el grupo destino en el curso destino
                curso_grupo_alumno_destino, created = CursoGrupoAlumno.objects.get_or_create(curso_grupo=curso_grupo_destino,
                                                                                             curso_alumno=curso_alumno_destino)
        data['status'] = 'OK'
        return JsonResponse(data)


# eliminar alumnos en el grupo desde formulario de traspasos
class CursoGrupoDeleteAlumnos(LoginRequiredMixin, GroupRequiredMixin, AjaxResponseMixin, View):

    group_required = ['informaticos']

    def post(self, *args, **kwargs):
        # en self.request.POST tenemos lista_alumnos_a_borrar
        lista_alumnos_a_borrar = self.request.POST.getlist('lista_alumnos_a_borrar[]')
        data = dict()
        CursoGrupoAlumno.objects.filter(pk__in=lista_alumnos_a_borrar).delete()
        data['status'] = 'OK'
        return JsonResponse(data)

