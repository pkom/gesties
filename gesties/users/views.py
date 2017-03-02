# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.conf import settings
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.db.models import Q
from django.contrib.auth import (
    REDIRECT_FIELD_NAME, login as auth_login
)
from django.contrib.auth.decorators import login_required
from django.contrib.sites.shortcuts import get_current_site
from django.views.decorators.csrf import csrf_protect
from django.utils.http import is_safe_url
from django.shortcuts import resolve_url
from django.http import JsonResponse, HttpResponseRedirect, HttpResponseNotAllowed
from django.views.decorators.cache import never_cache
from django.core.urlresolvers import reverse
from django.template.response import TemplateResponse
from django.views.generic import DetailView, ListView, RedirectView, UpdateView
from django.contrib.auth import get_user_model
from django.contrib.auth.mixins import LoginRequiredMixin

from gesties.core.decorators import ajax_required
from gesties.core.serializers import serializer
from gesties.core.users import user_status
from gesties.configies.models import Configies
from gesties.grupos.models import CursoGrupo
from gesties.departamentos.models import CursoDepartamento

from gesties.users.forms import AutenticacionForm
from gesties.users.models import CursoProfesor


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
                request.session['configies']['logo_centro_url'] = Configies.objects.first().logo_centro.url
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
        if search is not None:
            ape = Q(profesor__last_name__icontains=search)
            nom = Q(profesor__first_name__icontains=search)
            qs = qs.filter(ape | nom)
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
                data['mensaje'] = "No existe al alumno con NIE {0}".format(nie)
                return JsonResponse(data, status=404)
        else:
            data['estado'] = "ERROR"
            data['mensaje'] = u"El método {0} HTTP no está permitido".format(request.method)
            return JsonResponse(data, status=405)
    else:
        return HttpResponseBadRequest(u'Lo siento, esto es una vista AJAX')


class CursoProfesorListView(LoginRequiredMixin, ListView):

    model = CursoProfesor
    template_name = 'users/cursoprofesor_list.html'
    paginate_by = 5

    def get_queryset(self):
        q = self.request.GET.get("q", None)
        qs = CursoProfesor.objects.filter(curso=self.request.session['curso_academico']['pk'])\
                .order_by('profesor__last_name', 'profesor__first_name')
        if q is not None:
            ape = Q(profesor__last_name__icontains=q)
            nom = Q(profesor__first_name__icontains=q)
            qs = qs.filter(ape | nom)
        return qs

    def get_context_data(self, **kwargs):
        # Call the base implementation first to get a context
        context = super(CursoProfesorListView, self).get_context_data(**kwargs)
        context['mdatos'] = True
        context['mprofesores'] = True
        return context



class CursoProfesorDetailView(LoginRequiredMixin, DetailView):

    model = User
    template_name = 'users/cursoprofesor_detail.html'
    slug_field = 'username'
    slug_url_kwarg = 'username'

    def get_context_data(self, **kwargs):
        # Call the base implementation first to get a context
        context = super(CursoProfesorDetailView, self).get_context_data(**kwargs)
        context['status'] = user_status(self.request,username=kwargs['object'].username)
        context['mdatos'] = True
        context['mprofesores'] = True
        return context



class UserRedirectView(LoginRequiredMixin, RedirectView):

    permanent = False

    def get_redirect_url(self):
        return reverse('users:detail-profesor',
                       kwargs={'username': self.request.user.username})


class UserUpdateView(LoginRequiredMixin, UpdateView):

    fields = ['name', 'foto', ]
    template_name = 'users/user_form.html'
    # we already imported User in the view code above, remember?
    model = User

    # send the user back to their own page after a successful update
    def get_success_url(self):
        return reverse('users:detail-profesor',
                       kwargs={'username': self.request.user.username})

    def get_object(self):
        # Only get the User record for the user making the request
        return User.objects.get(username=self.request.user.username)

    def get_context_data(self, **kwargs):
        # Call the base implementation first to get a context
        context = super(UserUpdateView, self).get_context_data(**kwargs)
        # context['status'] = user_status(self.request,username=kwargs['object'].username)
        context['mdatos'] = True
        context['mprofesores'] = True
        return context
