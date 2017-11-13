# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals
import uuid

from PIL import Image

from django.conf import settings
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.db.models import Q
from django.contrib.auth import (
    REDIRECT_FIELD_NAME, login as auth_login
)
from django.contrib.auth.decorators import login_required
from django.contrib.sites.shortcuts import get_current_site
from django.contrib.staticfiles.templatetags.staticfiles import static
from django.views.decorators.csrf import csrf_protect, csrf_exempt
from django.utils.http import is_safe_url
from django.shortcuts import resolve_url
from django.http import JsonResponse, HttpResponseRedirect, HttpResponseNotAllowed, HttpResponseBadRequest
from django.views.decorators.cache import never_cache
from django.template.response import TemplateResponse
from django.template.loader import render_to_string
from django.contrib.auth import get_user_model

from gesties.core.decorators import ajax_required
from gesties.core.serializers import serializer
from gesties.core.users import user_status
from gesties.configies.models import Configies
from gesties.grupos.models import CursoGrupo
from gesties.departamentos.models import CursoDepartamento

from gesties.users.forms import AutenticacionForm, UserFotoForm
from gesties.users.models import CursoProfesor
from gesties.departamentos.models import CursoDepartamentoProfesor


User = get_user_model()


def _get_login_redirect_url(request, redirect_to):
    # Ensure the user-originating redirection URL is safe.
    if not is_safe_url(url=redirect_to, host=request.get_host()):
        return resolve_url(settings.LOGIN_REDIRECT_URL)
    return redirect_to


@never_cache
@csrf_protect
def Userlogin(request, template_name='users/user_login.html',
          redirect_field_name=REDIRECT_FIELD_NAME,
          authentication_form=AutenticacionForm,
          extra_context=None, redirect_authenticated_user=False):
    """
    Displays the login form and handles the login action.
    """
    redirect_to = request.POST.get(redirect_field_name, request.GET.get(redirect_field_name, ''))

    if redirect_authenticated_user and request.user.is_authenticated:
        redirect_to = _get_login_redirect_url(request, redirect_to)
        if redirect_to == request.path:
            raise ValueError(
                "Redirection loop for authenticated user detected. Check that "
                "your LOGIN_REDIRECT_URL doesn't point to a login page."
            )
        return HttpResponseRedirect(redirect_to)
    elif request.method == "POST":
        form = authentication_form(request, data=request.POST)
        if form.is_valid():
            auth_login(request, form.get_user())
            request.session['esAdministrativo'] = False
            request.session['esResponsable'] = False
            request.session['esTutor'] = False
            request.session['esJefe'] = False
            if request.user.groups.filter(name='responsables').exists():
                request.session['esResponsable'] = True
            if request.user.groups.filter(name='administrativos').exists():
                request.session['esAdministrativo'] = True
            if request.user.groups.filter(name='informaticos').exists():
                request.session['esInformatico'] = True
            cursoprofesor = CursoProfesor.objects.filter(curso=form.cleaned_data["curso_academico"], profesor=request.user)
            if cursoprofesor:
                request.session['cursoprofesor'] = serializer(cursoprofesor[0]).serializer()
            else:
                cursogrupo = CursoGrupo.objects.filter(tutor=cursoprofesor, curso=form.cleaned_data["curso_academico"])
                if cursogrupo:
                    request.session['esTutor'] = True
                    # Su tutoría
                    request.session['tutoria'] = serializer(cursogrupo[0]).serializer()
                    request.session['tutoria']['nombre_grupo'] = cursogrupo[0].grupo.grupo
                cursodepartamento = CursoDepartamento.objects.filter(jefe=cursoprofesor, curso=form.cleaned_data["curso_academico"])
                if cursodepartamento:
                    request.session['esJefe'] = True
                    # Su tutoría
                    request.session['jefatura'] = serializer(cursodepartamento[0]).serializer()
                    request.session['jefatura']['nombre_dpto'] = cursodepartamento[0].departamento.departamento
            request.session['configies'] = serializer(Configies.objects.first()).serializer()
            if Configies.objects.first().logo_centro:
                request.session['configies']['fields']['logo_centro_url'] = Configies.objects.first().logo_centro.url
            request.session['curso_academico'] = serializer(form.cleaned_data["curso_academico"]).serializer()
            return HttpResponseRedirect(_get_login_redirect_url(request, redirect_to))
    else:
        form = authentication_form(request, initial={"curso_academico": Configies.objects.first().curso_defecto})

    current_site = get_current_site(request)

    context = {
        'form': form,
        redirect_field_name: redirect_to,
        'site': current_site,
        'site_name': current_site.name,
    }
    if extra_context is not None:
        context.update(extra_context)

    return TemplateResponse(request, template_name, context)


@ajax_required
@login_required
def load_profesores(request):
    if request.method == 'GET':
        return TemplateResponse(request, 'partials/profesores/_profesor_list.html', {})
    else:
        return HttpResponseNotAllowed(['GET'])


@ajax_required
@login_required
def load_profesores_datatables(request):
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
        qs = CursoProfesor.objects.filter(curso=request.session['curso_academico']['pk'])
        if ordercol == '1':
            if orderdir == 'asc':
                qs = qs.order_by('profesor__last_name', 'profesor__first_name', 'profesor__dni')
            else:
                qs = qs.order_by('-profesor__last_name', '-profesor__first_name', '-profesor__dni')

        recordsTotal = qs.count()
        recordsFiltered = recordsTotal
        if search != "":
            ape = Q(profesor__last_name__icontains=search)
            nom = Q(profesor__first_name__icontains=search)

            #filtrado por departamentos
            deps = CursoDepartamentoProfesor.objects.filter(curso_departamento__curso=request.session['curso_academico']['pk'],
                curso_departamento__departamento__departamento__icontains=search)
            dep = Q(departamentos__in=deps)

            qs = qs.filter( ape | nom | dep )
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
        for profesor in qs:
            profe = dict()
            profe["DT_RowId"] = str(profesor.profesor.dni)
            profe["DT_RowData"] = {
                "pkey": profesor.profesor.dni
            },
            profe['foto'] = profesor.profesor.foto_html()
            profe['nombre'] = profesor.profesor.get_nombre_completo
            if profesor.departamentos.all().filter().first():
                profe['departamento'] = profesor.departamentos.all().filter().first().curso_departamento.departamento.departamento
            else:
                profe['departamento'] = u'Sin departamento'
            profe['telefono'] = profesor.profesor.telefono
            data['data'].append(profe)
    else:
        data['error'] = u'El método no está autorizado'
    return JsonResponse(data)

@ajax_required
@login_required()
def ver_profesor(request, dni=None):

    data = dict()
    if dni:
        if request.method == "GET":
            profe = CursoProfesor.objects.filter(profesor__dni=dni)
            if profe.exists():
                #preparar contexto
                context = {'profesor': user_status(request, username=profe[0].profesor.username)}
                data['estado'] = 'OK'
                data['html'] = render_to_string('partials/profesores/_profesor_detail.html', context)
                return JsonResponse(data, status=200)
            else:
                data['estado'] = "ERROR"
                data['mensaje'] = "No existe el profesor con DNI {0}".format(dni)
                return JsonResponse(data, status=404)
        else:
            data['estado'] = "ERROR"
            data['mensaje'] = u"El método {0} HTTP no está permitido".format(request.method)
            return JsonResponse(data, status=405)
    else:
        return HttpResponseBadRequest(u'Lo siento, esto es una vista AJAX')

@ajax_required
@login_required
def modifica_perfil(request):

    user = request.user
    if request.method == 'POST':
        form = UserFotoForm(request.POST, request.FILES, instance=user)
        result = {}
        if form.is_valid():
            form.save()
            result['status'] = 'OK'
            result['message'] = u'La fotografía se ha actualizado correctamente'
            result['url'] = user.foto.url
            return JsonResponse(result)
        else:
            result['status'] = 'ERR'
            result['message'] = u'No ha sido posible establecer la fotografía'
            return JsonResponse(result)
    else:
        form = UserFotoForm(instance=request.user)

    # figure out number of reports and last activities
    context = dict()
    context['partes'] = 23
    context['retrasos'] = 2
    context['absentismos'] = 3
    context['recents'] = [
        {},
        {},
        {},
        {},
        {},
        {},
        {},
    ]
    context['form'] = form
    return TemplateResponse(request, 'partials/profesores/_user_profile.html', context)


@csrf_exempt
@ajax_required
@login_required
def modifica_foto(request):

    user = request.user
    result = {}
    if request.method == 'POST':
        if 'foto-clear' in request.POST:
            limpiar = True if request.POST['foto-clear'] == 'on' else False
        else:
            limpiar = False
        if 'pk' in request.POST:
            pk = request.POST['pk']
        else:
            pk = request.user.pk
        if 'x' in request.POST:
            x = request.POST['x']
        if 'y' in request.POST:
            y = request.POST['y']
        if 'width' in request.POST:
            w = request.POST['width']
        if 'height' in request.POST:
            h = request.POST['height']
        if 'avatar' in request.FILES:
            foto = request.FILES['avatar']
        if 'foto' in request.FILES:
            foto = request.FILES['foto']

        if limpiar:
            user.foto.delete()
            user.save()
            result['status'] = 'OK'
            result['message'] = u'La fotografía se ha eliminado'
            result['url'] = static('avatars/nobody.png')
            return JsonResponse(result)

        else:
            try:
                x = float(x)
                y = float(y)
                w = float(w)
                h = float(h)
            except NameError:
                cropping = False
            else:
                cropping = True


            if foto:
                if user.foto:
                    user.foto.delete()

                #user.foto.save(foto.name, foto)

                import os
                filename, file_extension = os.path.splitext(foto.name)
                user.foto.save(str(uuid.uuid4())+file_extension, foto)

                image = Image.open(foto)

                if cropping:
                    cropped_image = image.crop((x, y, w + x, h + y))
                else:
                    cropped_image = image
                resized_image = cropped_image.resize((200, 200), Image.ANTIALIAS)
                resized_image.save(user.foto.path)

                result['status'] = 'OK'
                result['message'] = u'La fotografía se ha actualizado correctamente'
                result['url'] = user.foto.url
                return JsonResponse(result)

            else:
                result['status'] = 'ERR'
                result['message'] = u'No se ha seleccionado ninguna fotografía'
                return JsonResponse(result)
    else:
        result['status'] = 'ERR'
        result['message'] = u'El método no está permitido'
        return HttpResponseNotAllowed(result)


@csrf_exempt
@ajax_required
@login_required
def modifica_name(request):

    user = request.user
    result = {}
    if request.method == 'POST':
        if 'name' in request.POST:
            name = request.POST['value']
            if name != "":
                user.name = name
                user.save()
                result['status'] = 'OK'
                result['message'] = 'Se ha actualizado el nombre'
            else:
                result['status'] = 'err'
                result['message'] = 'El nombre no puede estar vacio'
            return JsonResponse(result)
        else:
            result['status'] = 'err'
            return HttpResponseBadRequest('No se ha podido actualizar ')
