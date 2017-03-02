# -*- coding: utf-8 -*-

from django.views.generic import DetailView, ListView
from django.contrib.auth.mixins import LoginRequiredMixin

from .models import CursoDepartamento


class CursoDepartamentoListView(LoginRequiredMixin, ListView):

    model = CursoDepartamento
    template_name = 'departamentos/cursodepartamento_list.html'

    def get_queryset(self):
        qs = CursoDepartamento.objects.filter(curso=self.request.session['curso_academico']['pk'])\
                .order_by('departamento__departamento')
        return qs

    def get_context_data(self, **kwargs):
        # Call the base implementation first to get a context
        context = super(CursoDepartamentoListView, self).get_context_data(**kwargs)
        context['mdatos'] = True
        context['mdepartamentos'] = True
        return context


class CursoDepartamentoDetailView(LoginRequiredMixin, DetailView):

    model = CursoDepartamento
    template_name = 'departamentos/cursodepartamento_detail.html'

    def get_context_data(self, **kwargs):
        # Call the base implementation first to get a context
        context = super(CursoDepartamentoDetailView, self).get_context_data(**kwargs)
        context['mdatos'] = True
        context['mdepartamentos'] = True
        return context
