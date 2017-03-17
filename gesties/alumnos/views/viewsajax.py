# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.shortcuts import get_object_or_404
from django.template.response import TemplateResponse
from django.http import JsonResponse, Http404, HttpResponseNotAllowed, HttpResponseBadRequest
from django.contrib.auth.decorators import login_required
from django.db.models import Q
from django.template.loader import render_to_string

from gesties.cursos.models import Curso
from gesties.core.users import student_status
from gesties.core.decorators import ajax_required


from gesties.alumnos.models import Alumno, CursoAlumno, Tutor
from gesties.alumnos.forms import AlumnoForm
from gesties.grupos.models import CursoGrupoAlumno

@ajax_required
@login_required
def load_alumnos(request):
    if request.method == 'GET':
        return TemplateResponse(request, 'partials/alumnos/_alumno_list.html', {})
    else:
        return HttpResponseNotAllowed(['GET'])


@ajax_required
@login_required
def load_alumnos_datatables(request):
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
        qs = CursoAlumno.objects.filter(curso=request.session['curso_academico']['pk'])
        if ordercol == '1':
            if orderdir == 'asc':
                qs = qs.order_by('alumno__apellidos', 'alumno__nombre', 'alumno__nie')
            else:
                qs = qs.order_by('-alumno__apellidos', '-alumno__nombre', '-alumno__nie')
        if ordercol == '3':
            if orderdir == 'asc':
                qs = qs.order_by('alumno__fecha_nacimiento')
            else:
                qs = qs.order_by('-alumno__fecha_nacimiento')

        recordsTotal = qs.count()
        recordsFiltered = recordsTotal
        if search != "":
            ape = Q(alumno__apellidos__icontains=search)
            nom = Q(alumno__nombre__icontains=search)
            fnac = Q(alumno__fecha_nacimiento__icontains=search)

            #filtrado por grupos
            grups = CursoGrupoAlumno.objects.filter(curso_grupo__curso=request.session['curso_academico']['pk'],
                curso_grupo__grupo__grupo__icontains=search)
            grup = Q(grupos__in=grups)

            qs = qs.filter(ape | nom | fnac | grup)
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
        for alumno in qs:
            alu = dict()
            alu["DT_RowId"] = str(alumno.alumno.nie)
            alu["DT_RowData"] = {
                "pkey": alumno.alumno.nie
            },
            alu['foto'] = alumno.alumno.foto_html()
            alu['nombre'] = alumno.alumno.get_nombre_completo
            if alumno.grupos.all().filter().first():
                alu['grupo'] = alumno.grupos.all().filter().first().curso_grupo.grupo.grupo
            else:
                alu['grupo'] = u'Sin grupo'
            if alumno.alumno.fecha_nacimiento:
                alu['fecha'] = alumno.alumno.fecha_nacimiento
            else:
                alu['fecha'] = u'Sin fecha'
            alu['edad'] = alumno.edad()
            alu['telefono'] = alumno.alumno.telefono
            data['data'].append(alu)
    else:
        data['error'] = u'El método no está autorizado'
    return JsonResponse(data)

@ajax_required
@login_required()
def ver_alumno(request, nie=None):

    data = dict()
    if nie:
        if request.method == "GET":
            if CursoAlumno.objects.filter(alumno__nie=nie).exists():
                #preparar contexto
                context = {'alumno': student_status(request, nie=nie)}
                data['estado'] = 'OK'
                data['html'] = render_to_string('partials/alumnos/_alumno_detail.html', context)
                return JsonResponse(data, status=200)
            else:
                data['estado'] = "ERROR"
                data['mensaje'] = "No existe alumno con NIE {0}".format(nie)
                return JsonResponse(data, status=404)
        else:
            data['estado'] = "ERROR"
            data['mensaje'] = u"El método {0} HTTP no está permitido".format(request.method)
            return JsonResponse(data, status=405)
    else:
        return HttpResponseBadRequest(u'Lo siento, esto es una vista AJAX')


@ajax_required
@login_required
def load_tutores(request):
    if request.method == 'GET':
        return TemplateResponse(request, 'partials/alumnos/_tutor_list.html', {})
    else:
        return HttpResponseNotAllowed(['GET'])


@ajax_required
@login_required
def load_tutores_datatables(request):
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
        qs = Tutor.objects.all()
        if ordercol == '1':
            if orderdir == 'asc':
                qs = qs.order_by('apellidos', 'nombre')
            else:
                qs = qs.order_by('-apellidos', '-nombre')

        recordsTotal = qs.count()
        recordsFiltered = recordsTotal
        if search != "":
            ape = Q(apellidos__icontains=search)
            nom = Q(nombre__icontains=search)
            tfno1 = Q(telefono1__icontains=search)
            tfno2 = Q(telefono2__icontains=search)
            qs = qs.filter( ape | nom | tfno1 | tfno2 )
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
        for tutor in qs:
            tut = dict()
            tut["DT_RowId"] = str(tutor.id)
            tut["DT_RowData"] = {
                "pkey": tutor.id
            },
            tut['foto'] = tutor.foto_html()
            tut['nombre'] = tutor.get_nombre_completo
            tut['telefono'] = tutor.telefono1+' '+tutor.telefono2
            data['data'].append(tut)
    else:
        data['error'] = u'El método no está autorizado'
    return JsonResponse(data)

@ajax_required
@login_required()
def ver_tutor(request, id=None):

    data = dict()
    if id:
        if request.method == "GET":
            qs = Tutor.objects.filter(id=id)
            if qs.exists():
                tutor = qs.first()
                #preparar contexto
                context = {'tutor': tutor }
                data['estado'] = 'OK'
                data['html'] = render_to_string('partials/alumnos/_tutor_detail.html', context)
                return JsonResponse(data, status=200)
            else:
                data['estado'] = "ERROR"
                data['mensaje'] = "No existe tutor con ID {0}".format(id)
                return JsonResponse(data, status=404)
        else:
            data['estado'] = "ERROR"
            data['mensaje'] = u"El método {0} HTTP no está permitido".format(request.method)
            return JsonResponse(data, status=405)
    else:
        return HttpResponseBadRequest(u'Lo siento, esto es una vista AJAX')



















def save_alumno_form(request, form, template_name):

    data = dict()
    if request.is_ajax:
        if request.method == 'POST':
            if form.is_valid():
                nuevo_alumno = form.save()
                # crear el alumno en el curso actual si no existe
                CursoAlumno.objects.update_or_create(alumno=nuevo_alumno,
                                                 curso=Curso.objects.get(id=request.session['curso_academico']['pk']))
                data['form_is_valid'] = True
                alumnos = CursoAlumno.objects.filter(curso=request.session['curso_academico']['pk']) \
                    .order_by('alumno__apellidos', 'alumno__nombre', 'alumno__nie')
                data['html_alumno_list'] = render_to_string('partials/alumnos/partial_alumno_list.html',
                                                            {'object_list': alumnos})
            else:
                data['form_is_valid'] = False
        context = {'form': form}
        data['html_form'] = render_to_string(template_name, context, request=request)
        return JsonResponse(data)
    else:
        raise Http404(u'Esto es una vista AJAX, amigo')


@login_required()
def alumno_create(request):

    if request.method == 'POST':
        form = AlumnoForm(request.POST)
    else:
        form = AlumnoForm()
    return save_alumno_form(request, form, 'partials/alumnos/partial_alumno_create.html')


@login_required()
def alumno_update(request, nie):

    alumno = get_object_or_404(Alumno, nie=nie)
    if request.method == 'POST':
        form = AlumnoForm(request.POST, instance=alumno)
    else:
        form = AlumnoForm(instance=alumno)
    return save_alumno_form(request, form, 'partials/alumnos/partial_alumno_update.html')


@login_required()
def CursoAlumnoList(request):

    data = dict()
    if request.is_ajax:
        q = request.GET.get("q", None)
        qs = CursoAlumno.objects.filter(curso=request.session['curso_academico']['pk']) \
            .order_by('alumno__apellidos', 'alumno__nombre', 'alumno__nie')
        if q is not None:
            ape = Q(alumno__apellidos__icontains=q)
            nom = Q(alumno__nombre__icontains=q)
            qs = qs.filter(ape | nom)

        paginator = Paginator(qs, 5)
        page = request.GET.get("page")
        try:
            qs = paginator.page(page)
        except PageNotAnInteger:
            # If page is not an integer, deliver first page.
            qs = paginator.page(1)
        except EmptyPage:
            # If page is out of range (e.g. 9999), deliver last page of results.
            qs = paginator.page(paginator.num_pages)

        context = {'qs': qs, 'q': q, 'page': page or 1, 'is_paginated': True }
        data['html'] = render_to_string('partials/alumnos/_alumno_list.html', context, request=request)
        return JsonResponse(data)
    else:
        raise Http404(u'Esto es una vista AJAX, amigo')


@login_required()
def CursoAlumnoParcialList(request):

    data = dict()
    if request.is_ajax:
        q = request.GET.get("q", None)
        qs = CursoAlumno.objects.filter(curso=request.session['curso_academico']['pk']) \
            .order_by('alumno__apellidos', 'alumno__nombre', 'alumno__nie')
        if q is not None:
            ape = Q(alumno__apellidos__icontains=q)
            nom = Q(alumno__nombre__icontains=q)
            qs = qs.filter(ape | nom)

        paginator = Paginator(qs, 5)
        page = request.GET.get("page")
        try:
            qs = paginator.page(page)
        except PageNotAnInteger:
            # If page is not an integer, deliver first page.
            qs = paginator.page(1)
        except EmptyPage:
            # If page is out of range (e.g. 9999), deliver last page of results.
            qs = paginator.page(paginator.num_pages)

        context = {'qs': qs, 'q': q, 'page': page or 1, 'is_paginated': True }
        data['html'] = render_to_string('partials/alumnos/partial_alumno_list.html', context, request=request)
        return JsonResponse(data)
    else:
        raise Http404(u'Esto es una vista AJAX, amigo')


@login_required
def load_alumnos_json(request):
    if request.is_ajax():
        data = dict()
        if request.method == 'GET':
            q = request.GET.get("q", None)
            qs = CursoAlumno.objects.filter(curso=request.session['curso_academico']['pk']) \
                .order_by('alumno__apellidos', 'alumno__nombre', 'alumno__nie')
            if q is not None:
                ape = Q(alumno__apellidos__icontains=q)
                nom = Q(alumno__nombre__icontains=q)
                qs = qs.filter(ape | nom)

            paginator = Paginator(qs, 5)
            page = request.GET.get("page")
            try:
                qs = paginator.page(page)
            except PageNotAnInteger:
                # If page is not an integer, deliver first page.
                qs = paginator.page(1)
            except EmptyPage:
                # If page is out of range (e.g. 9999), deliver last page of results.
                qs = paginator.page(paginator.num_pages)
            context = {'qs': qs, 'q': q, 'page': page or 1, 'is_paginated': True}
            data['html'] = render_to_string('partials/alumnos/_alumno_list.html', context, request=request)
        else:
            data['error'] = u'El método no está autorizado'
        return JsonResponse(data)
    else:
        raise Http404(u'Lo siento, pero esto es una vista AJAX.')
