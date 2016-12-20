# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.conf import settings
from django.contrib.auth import (
    REDIRECT_FIELD_NAME, login as auth_login
)
from django.contrib.sites.shortcuts import get_current_site
from django.views.decorators.csrf import csrf_protect
from django.utils.http import is_safe_url
from django.shortcuts import resolve_url
from django.http import HttpResponseRedirect
from django.views.decorators.cache import never_cache
from django.core.urlresolvers import reverse
from django.template.response import TemplateResponse
from django.views.generic import DetailView, ListView, RedirectView, UpdateView
from django.contrib.auth.mixins import LoginRequiredMixin

from gesties.utils.serializers import serializer
from gesties.configies.models import Configies
from gesties.grupos.models import CursoGrupo
from gesties.departamentos.models import CursoDepartamento

from .models import User
from .forms import AutenticacionForm


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
            request.session['esResponsable'] = False
            request.session['esTutor'] = False
            request.session['esJefe'] = False
            if request.user.groups.filter(name='responsables').exists():
                request.session['esResponsable'] = True
            cursogrupo = CursoGrupo.objects.filter(tutor=request.user, curso=form.cleaned_data["curso_academico"])
            if cursogrupo:
                request.session['esTutor'] = True
                # Su tutoría
                request.session['tutoria'] = serializer(cursogrupo[0]).serializer()
                request.session['tutoria']['nombre_grupo'] = cursogrupo[0].grupo.grupo
            cursodepartamento = CursoDepartamento.objects.filter(jefe=request.user, curso=form.cleaned_data["curso_academico"])
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


class UserDetailView(LoginRequiredMixin, DetailView):
    model = User
    # These next two lines tell the view to index lookups by username
    slug_field = 'username'
    slug_url_kwarg = 'username'


class UserRedirectView(LoginRequiredMixin, RedirectView):
    permanent = False

    def get_redirect_url(self):
        return reverse('users:detail',
                       kwargs={'username': self.request.user.username})


class UserUpdateView(LoginRequiredMixin, UpdateView):

    fields = ['name', ]

    # we already imported User in the view code above, remember?
    model = User

    # send the user back to their own page after a successful update
    def get_success_url(self):
        return reverse('users:detail',
                       kwargs={'username': self.request.user.username})

    def get_object(self):
        # Only get the User record for the user making the request
        return User.objects.get(username=self.request.user.username)


class UserListView(LoginRequiredMixin, ListView):
    model = User
    # These next two lines tell the view to index lookups by username
    slug_field = 'username'
    slug_url_kwarg = 'username'
