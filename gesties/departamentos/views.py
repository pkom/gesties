# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.views.generic import DetailView, ListView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.auth.decorators import login_required
from django.template.response import TemplateResponse
from django.template.loader import render_to_string
from django.http import JsonResponse, HttpResponseBadRequest, HttpResponseNotAllowed
from django.db.models import Q

from gesties.core.decorators import ajax_required
from .models import CursoDepartamento


@ajax_required
@login_required
def load_departamentos(request):
    if request.method == 'GET':
        return TemplateResponse(request, 'partials/departamentos/_departamento_list.html', {})
    else:
        return HttpResponseNotAllowed(['GET'])


@ajax_required
@login_required
def load_departamentos_datatables(request):
    data = dict()
    if request.method == 'GET':
        length = request.GET.get("length", 5)
        start = request.GET.get("start", 0)
        search = request.GET.get("search[value]", None)
        if isinstance(search, list):
            search = search[0]
        ordercol = request.GET.get("order[0][column]", None)
        if isinstance(ordercol, list):
            ordercol = ordercol[0]
        orderdir = request.GET.get("order[0][dir]", None)
        if isinstance(orderdir, list):
            orderdir = orderdir[0]
        qs = CursoDepartamento.objects.filter(curso=request.session['curso_academico']['pk'])
        if ordercol == '0':
            if orderdir == 'asc':
                qs = qs.order_by('departamento__departamento')
            else:
                qs = qs.order_by('-departamento__departamento')
        if ordercol == '2':

            if orderdir == 'asc':
                qs = qs.order_by('jefe__profesor__last_name', 'jefe__profesor__first_name')
            else:
                qs = qs.order_by('-jefe__profesor__last_name', '-jefe__profesor__first_name')

        recordsTotal = qs.count()
        recordsFiltered = recordsTotal
        if search != "":
            dpto = Q(departamento__departamento__icontains=search)
            ape = Q(jefe__profesor__last_name__icontains=search)
            nom = Q(jefe__profesor__first_name__icontains=search)
            qs = qs.filter( dpto | ape | nom )
            recordsFiltered = qs.count()
        paginator = Paginator(qs, length)
        try:
            page = int(start) / int(length) + 1
        except:
            page = 1
        try:
            qs = paginator.page(page)
        except PageNotAnInteger:
            # If page is not an integer, deliver first page.
            qs = paginator.page(1)
        except EmptyPage:
            # If page is out of range (e.g. 9999), deliver last page of results.
            qs = paginator.page(paginator.num_pages)
        data['draw'] = int(request.GET.get('draw'))
        data['recordsTotal'] = recordsTotal
        data['recordsFiltered'] = recordsFiltered
        data['data'] = []
        for departamento in qs:
            dpto = dict()
            dpto["DT_RowId"] = str(departamento.id)
            dpto["DT_RowData"] = {
                "pkey": departamento.departamento.id
            },
            dpto['dpto'] = departamento.departamento.departamento
            dpto['foto'] = departamento.jefe.profesor.foto_html()
            dpto['jefe'] = departamento.jefe.profesor.get_nombre_completo
            dpto['profesores'] = departamento.profesores.all().count()
            data['data'].append(dpto)
    else:
        data['error'] = u'El método no está autorizado'
    return JsonResponse(data)

@ajax_required
@login_required()
def ver_departamento(request, departamento=None):

    data = dict()
    if departamento:
        if request.method == "GET":
            qs = CursoDepartamento.objects.filter(id=departamento)
            if qs.exists():
                dpto = qs.first()
                #preparar contexto
                context = {}
                context['dpto'] = dpto.departamento
                context['jefe'] = dpto.jefe
                context['profesores'] = dpto.profesores.all()
                data['estado'] = 'OK'
                data['html'] = render_to_string('partials/departamentos/_departamento_detail.html', context)
                return JsonResponse(data, status=200)
            else:
                data['estado'] = "ERROR"
                data['mensaje'] = "No existe grupo con ID {0}".format(grupo)
                return JsonResponse(data, status=404)
        else:
            data['estado'] = "ERROR"
            data['mensaje'] = u"El método {0} HTTP no está permitido".format(request.method)
            return JsonResponse(data, status=405)
    else:
        return HttpResponseBadRequest(u'Lo siento, esto es una vista AJAX')


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
