# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import DetailView, ListView
from django.db.models import Q

from gesties.core.users import student_status
from gesties.alumnos.models import Alumno, CursoAlumno, Tutor


class CursoAlumnoListView(LoginRequiredMixin, ListView):

    model = CursoAlumno
    template_name = 'alumnos/cursoalumno_list.html'
    paginate_by = 5


    def get_queryset(self):
        q = self.request.GET.get("q", None)
        qs = CursoAlumno.objects.filter(curso=self.request.session['curso_academico']['pk'])\
                .order_by('alumno__apellidos', 'alumno__nombre', 'alumno__nie')
        if q is not None:
            ape = Q(alumno__apellidos__icontains=q)
            nom = Q(alumno__nombre__icontains=q)
            qs = qs.filter(ape | nom)
        return qs

    def get_context_data(self, **kwargs):
        # Call the base implementation first to get a context
        context = super(CursoAlumnoListView, self).get_context_data(**kwargs)
        context['mdatos'] = True
        context['malumnos'] = True
        return context


class CursoAlumnoDetailView(LoginRequiredMixin, DetailView):

    model = Alumno
    template_name = 'alumnos/cursoalumno_detail.html'
    slug_field = 'nie'
    slug_url_kwarg = 'nie'

    def get_context_data(self, **kwargs):
        # Call the base implementation first to get a context
        context = super(CursoAlumnoDetailView, self).get_context_data(**kwargs)
        context['status'] = student_status(self.request,nie=kwargs['object'].nie)
        context['mdatos'] = True
        context['malumnos'] = True
        return context


class TutorListView(LoginRequiredMixin, ListView):

    model = Tutor
    template_name = 'alumnos/tutores_list.html'
    paginate_by = 5

    def get_queryset(self):
        q = self.request.GET.get("q", None)
        qs = Tutor.objects.all().order_by('apellidos', 'nombre')
        if q is not None:
            ape = Q(apellidos__icontains=q)
            nom = Q(nombre__icontains=q)
            qs = qs.filter(ape | nom)
        return qs

    def get_context_data(self, **kwargs):
        # Call the base implementation first to get a context
        context = super(TutorListView, self).get_context_data(**kwargs)
        context['mdatos'] = True
        context['mtutores'] = True
        return context


class TutorAlumnoDetailView(LoginRequiredMixin, DetailView):

    model = Tutor
    template_name = 'alumnos/tutor_detail.html'
    slug_field = 'dni'
    slug_url_kwarg = 'dni'

    def get_context_data(self, **kwargs):
        # Call the base implementation first to get a context
        context = super(TutorAlumnoDetailView, self).get_context_data(**kwargs)
        context['mdatos'] = True
        context['mtutores'] = True
        return context


