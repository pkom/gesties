# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.views.generic import DetailView, ListView, RedirectView, UpdateView
from django.contrib.auth.mixins import LoginRequiredMixin

from gesties.grupos.models import CursoGrupo


class CursoGrupoListView(LoginRequiredMixin, ListView):

    model = CursoGrupo
    template_name = 'grupos/cursogrupo_list.html'

    def get_queryset(self):
        qs = CursoGrupo.objects.filter(curso=self.request.session['curso_academico']['pk'])\
                .order_by('grupo__grupo')
        return qs

    def get_context_data(self, **kwargs):
        # Call the base implementation first to get a context
        context = super(CursoGrupoListView, self).get_context_data(**kwargs)
        context['mdatos'] = True
        context['mgrupos'] = True
        return context


class CursoGrupoDetailView(LoginRequiredMixin, DetailView):

    model = CursoGrupo
    template_name = 'grupos/cursogrupo_detail.html'

    def get_context_data(self, **kwargs):
        # Call the base implementation first to get a context
        context = super(CursoGrupoDetailView, self).get_context_data(**kwargs)
        context['mdatos'] = True
        context['mgrupos'] = True
        return context


