# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.shortcuts import get_object_or_404
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.views.generic import View
from django.template.response import TemplateResponse
from django.http import JsonResponse
from django.template.loader import render_to_string
from django.contrib.auth.decorators import login_required
from django.db.models import Q

from braces.views import LoginRequiredMixin, GroupRequiredMixin, AjaxResponseMixin

from gesties.core.decorators import ajax_required
from .models import Libro, Autor, Editorial, Area, Nivel, Ciclo
from .forms import LibroForm, LibroFormSet, PrestamoManualForm, PrestamoAutomaticoForm, ImprimeCBForm


class load_libros(LoginRequiredMixin, GroupRequiredMixin, AjaxResponseMixin, View):

    group_required = [u'responsables', u'administrativos']

    def get(self, request, *args, **kwargs):
        form = LibroForm(request)
        context = dict()
        context['form'] = form
        return TemplateResponse(request, 'partials/libros/_libro_list.html', context)


class load_prestamos_manual(LoginRequiredMixin, GroupRequiredMixin, AjaxResponseMixin, View):

    group_required = [u'responsables', u'administrativos']

    def get(self, request, *args, **kwargs):
        form = PrestamoManualForm(request)
        context = dict()
        context['form'] = form
        return TemplateResponse(request, 'partials/prestamos/_prestamos_manual.html', context)


class load_prestamos_automatica(LoginRequiredMixin, GroupRequiredMixin, AjaxResponseMixin, View):

    group_required = [u'responsables', u'administrativos']

    def get(self, request, *args, **kwargs):
        form = PrestamoAutomaticoForm(request)
        context = dict()
        context['form'] = form
        return TemplateResponse(request, 'partials/prestamos/_prestamos_automatico.html', context)


@ajax_required
@login_required
def load_libros_datatables(request):
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
        qs = Libro.objects.all()
        if ordercol == '0':
            if orderdir == 'asc':
                qs = qs.order_by('titulo')
            else:
                qs = qs.order_by('-titulo')
        #if ordercol == '1':
        #    if orderdir == 'asc':
        #        qs = qs.order_by('autor__autor')
        #    else:
        #        qs = qs.order_by('-autor__autor')
        if ordercol == '1':
            if orderdir == 'asc':
                qs = qs.order_by('editorial__editorial')
            else:
                qs = qs.order_by('-editorial__editorial')
        if ordercol == '2':
            if orderdir == 'asc':
                qs = qs.order_by('area_conocimiento__area')
            else:
                qs = qs.order_by('-area_conocimiento__area')

        if ordercol == '4':
            if orderdir == 'asc':
                qs = qs.order_by('nivel')
            else:
                qs = qs.order_by('-nivel')
        if ordercol == '5':
            if orderdir == 'asc':
                qs = qs.order_by('numero_ejemplares', 'titulo')
            else:
                qs = qs.order_by('-numero_ejemplares', 'titulo')

        recordsTotal = qs.count()
        recordsFiltered = recordsTotal
        if search != "":
            tit = Q(titulo__icontains=search)
            aut = Q(autor__autor__icontains=search)
            edi = Q(editorial__editorial__icontains=search)
            are = Q(area_conocimiento__area__icontains=search)
            isb = Q(isbn__icontains=search)
            cb = Q(codigo_barras__icontains=search)
            cic = Q(nivel__ciclo__ciclo__icontains=search)
            qs = qs.filter(tit | aut | edi | are | isb | cb | cic)
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
        for libro in qs:
            lib = dict()
            lib["DT_RowId"] = str(libro.id)
            lib["DT_RowData"] = {
                "pkey": libro.id
            },
            lib['titulo'] = libro.titulo
            #lib['autor'] = libro.autor
            if libro.autor:
                lib['autor'] = libro.autor.autor
            else:
                lib['autor'] = u'Sin autor/a'
            if libro.editorial:
                lib['editorial'] = libro.editorial.editorial
            else:
                lib['editorial'] = u'Sin editorial'
            lib['anio_edicion'] = libro.anio_edicion
            #lib['area_conocimiento'] = libro.area_conocimiento
            if libro.area_conocimiento:
                lib['area_conocimiento'] = libro.area_conocimiento.area
            else:
                lib['area_conocimiento'] = u'Sin área'
            lib['isbn'] = libro.isbn
            lib['codigo_barras'] = libro.codigo_barras
            #lib['nivel'] = libro.nivel
            if libro.nivel:
                lib['nivel'] = "{} ({})".format(libro.nivel.nivel, libro.nivel.ciclo.ciclo)
            else:
                lib['nivel'] = u'Sin nivel'
            lib['numero_ejemplares'] = libro.numero_ejemplares
            lib['bajas'] = libro.bajas
            lib['prestados'] = libro.prestados
            lib['disponibles'] = libro.disponibles
            lib['deteriorados'] = libro.deteriorados
            lib['precio'] = libro.precio
            lib['fecha_inicio'] = libro.fecha_inicio
            lib['fecha_fin'] = libro.fecha_fin
            data['data'].append(lib)
    else:
        data['error'] = u'El método no está autorizado'
    return JsonResponse(data)


def save_book_form(request, form, template_name):
    data = dict()
    if request.method == 'POST':
        if form.is_valid():
            libro = form.save(commit=False)
            libro.titulo = form.cleaned_data.get('titulo').upper()
            # tenemos que comprobar si existe algún valor en los campos alta_*
            # para crear las instancias correspondientes y asignárselas a los campos
            # correspondientes del libro
            if form.cleaned_data.get('autor') is None and form.cleaned_data.get('alta_autor') is not None:
                autor, created_autor = Autor.objects.get_or_create(autor=form.cleaned_data.get('alta_autor').upper())
                libro.autor = autor
            if form.cleaned_data.get('editorial') is None and form.cleaned_data.get('alta_editorial') is not None:
                editorial, created_editorial = Editorial.objects.get_or_create(editorial=form.cleaned_data.get('alta_editorial').upper())
                libro.editorial = editorial
            if form.cleaned_data.get('area_conocimiento') is None and form.cleaned_data.get('alta_area') is not None:
                area, created_area = Area.objects.get_or_create(area=form.cleaned_data.get('alta_area').upper())
                libro.area_conocimiento = area
            if form.cleaned_data.get('nivel') is None:
                if form.cleaned_data.get('alta_nivel') and form.cleaned_data.get('alta_ciclo'):
                    ciclo, created_ciclo = Ciclo.objects.get_or_create(ciclo=form.cleaned_data.get('alta_ciclo').upper())
                    if form.cleaned_data.get('alta_descripcion_ciclo'):
                        ciclo.descripcion = form.cleaned_data.get('alta_descripcion_ciclo')
                        ciclo.save()
                    nivel, created_nivel = Nivel.objects.get_or_create(ciclo=ciclo, nivel=form.cleaned_data.get('alta_nivel'))
                    libro.nivel = nivel

            libro.save()
            data['form_is_valid'] = True
        else:
            data['form_is_valid'] = False
    context = {'form': form }
    data['html_form'] = render_to_string(template_name,
                    context,
                    request=request,
    )
    return JsonResponse(data)


@ajax_required
@login_required
def create_libro(request):
    if request.method == 'POST':
        form = LibroForm(request.POST)
    else:
        form = LibroForm()
    return save_book_form(request, form, 'partials/libros/_libro_create.html')


@ajax_required
@login_required
def update_libro(request, pk):
    libro = get_object_or_404(Libro, pk=pk)
    if request.method == 'POST':
        form = LibroForm(request.POST, instance=libro)
    else:
        form = LibroForm(instance=libro)
    return save_book_form(request, form, 'partials/libros/_libro_update.html')


@ajax_required
@login_required
def ejemplares_libro(request, pk):
    libro = get_object_or_404(Libro, pk=pk)
    data = {}
    if request.method == 'POST':
        formset = LibroFormSet(request.POST, instance=libro)
        if formset.is_valid():
            formset.save()
            libro.numero_ejemplares = libro.ejemplar_set.all().count()
            libro.save()
            #ejemplares = formset.save(commit=False)
            #for ejemplar in ejemplares:
            #    print('Ejemplar modificado', ejemplar)
            #    ejemplar.save()
            # los siguientes están marcados para borrar
            #for ejemplar in formset.deleted_objects:
            #    print('Ejemplar eliminado', ejemplar)
            #    ejemplar.delete()
            data['form_is_valid'] = True
        else:
            data['form_is_valid'] = False
    else:
        formset = LibroFormSet(instance=libro)

    context = {'formset': formset }
    data['html_form'] = render_to_string('partials/libros/_libro_ejemplares.html',
                    context,
                    request=request,
    )
    return JsonResponse(data)


@ajax_required
@login_required
def imprime_ejemplares_cb(request, pk):
    libro = get_object_or_404(Libro, pk=pk)
    data = {}
    form = ImprimeCBForm(instance=libro)
    context = {'form': form }
    data['html_form'] = render_to_string('partials/libros/_libro_ejemplares_cb.html',
                    context,
                    request=request,
    )
    return JsonResponse(data)
