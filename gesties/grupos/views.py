# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.contrib.auth.decorators import login_required
from django.views.generic import DetailView, ListView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.template.response import TemplateResponse
from django.http import JsonResponse, HttpResponseNotAllowed, HttpResponseBadRequest
from django.template.loader import render_to_string
from django.db.models import Q

from gesties.core.decorators import ajax_required
from .models import CursoGrupo


@ajax_required
@login_required
def load_grupos(request):
    if request.method == 'GET':
        return TemplateResponse(request, 'partials/grupos/_grupo_list.html', {})
    else:
        return HttpResponseNotAllowed(['GET'])


@ajax_required
@login_required
def load_grupos_datatables(request):
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
        qs = CursoGrupo.objects.filter(curso=request.session['curso_academico']['pk'])
        if ordercol == '0':
            if orderdir == 'asc':
                qs = qs.order_by('grupo__grupo')
            else:
                qs = qs.order_by('-grupo__grupo')
        if ordercol == '2':

            if orderdir == 'asc':
                qs = qs.order_by('tutor__profesor__last_name', 'tutor__profesor__first_name')
            else:
                qs = qs.order_by('-tutor__profesor__last_name', '-tutor__profesor__first_name')

        recordsTotal = qs.count()
        recordsFiltered = recordsTotal
        if search != "":
            gru = Q(grupo__grupo__icontains=search)
            ape = Q(tutor__profesor__last_name__icontains=search)
            nom = Q(tutor__profesor__first_name__icontains=search)
            qs = qs.filter( gru | ape | nom )
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
        for grupo in qs:
            gru = dict()
            gru["DT_RowId"] = str(grupo.id)
            gru["DT_RowData"] = {
                "pkey": grupo.grupo.id
            },
            gru['grupo'] = grupo.grupo.grupo
            gru['foto'] = grupo.tutor.profesor.foto_html()
            gru['tutor'] = grupo.tutor.profesor.get_nombre_completo
            gru['alumnos'] = grupo.alumnos.all().count()
            gru['profesores'] = grupo.profesores.all().count()
            data['data'].append(gru)
    else:
        data['error'] = u'El método no está autorizado'
    return JsonResponse(data)

@ajax_required
@login_required()
def ver_grupo(request, grupo=None):

    data = dict()
    if grupo:
        if request.method == "GET":
            qs = CursoGrupo.objects.filter(id=grupo)
            if qs.exists():
                grupo = qs.first()
                #preparar contexto
                context = {}
                context['grupo'] = grupo.grupo
                context['tutor'] = grupo.tutor
                context['alumnos'] = grupo.alumnos.all()
                context['profesores'] = grupo.profesores.all()
                data['estado'] = 'OK'
                data['html'] = render_to_string('partials/grupos/_grupo_detail.html', context)
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


