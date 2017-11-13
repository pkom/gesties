# -*- coding: utf-8 -*-

from django.http import JsonResponse, HttpResponseBadRequest
from django.shortcuts import render
from django.template.loader import render_to_string
from django.contrib.auth.decorators import login_required
from django.template.response import TemplateResponse
from django.views.generic import View

from braces.views import LoginRequiredMixin, GroupRequiredMixin, AjaxResponseMixin

from gesties.core.users import get_current_users
from .forms import TraspasoForm
from .users import user_status


@login_required
def index(request):
    return TemplateResponse(request, 'baseajax.html')


@login_required
def load_index(request):
    context = dict()
    if request.method == 'GET':
        #context['usuarios'] = get_current_users()
        context['status'] = user_status(request, username=request.user.username)
    else:
        HttpResponseBadRequest(u'El método no está permitido')
    return TemplateResponse(request, 'partials/_index.html', context)


class load_traspaso(LoginRequiredMixin, GroupRequiredMixin, AjaxResponseMixin, View):

    group_required = ['informaticos']

    def get(self, request, *args, **kwargs):
        form = TraspasoForm()
        context = dict()
        context['form'] = form
        return TemplateResponse(request, 'partials/core/_traspaso_list.html', context)


@login_required
def load_sidebar(request):
    data = dict()
    if request.method == 'GET':
        context = {}
        data['html'] = render_to_string('componentes/sidebar.html', context, request=request)
    else:
        data['error'] = u'El método no está autorizado'
    return JsonResponse(data)


# para comprobar los locales del sistema donde está corriento la aplicación
import sys
import locale
def locales(request):
    """Display the locales"""
    locales = "Current locale: %s %s -- Default locale: %s %s" % (
        locale.getlocale() + locale.getdefaultlocale())
    default_encoding =  sys.getdefaultencoding()
    file_system_encoding = sys.getfilesystemencoding()

    context = {
        'locales': locales,
        'default_encoding': default_encoding,
        'file_system_encoding': file_system_encoding,  # affects file uploads
    }
    return render(request, 'testing/locales.html', context)
