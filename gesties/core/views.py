# -*- coding: utf-8 -*-

from django.http import JsonResponse, HttpResponseBadRequest
from django.shortcuts import Http404
from django.template.loader import render_to_string
from django.contrib.auth.decorators import login_required
from django.template.response import TemplateResponse
#from django.contrib import messages

from gesties.core.users import get_current_users

from .users import user_status


@login_required
def index(request):
    contexto = {'usuarios': get_current_users()}
    contexto['status'] = user_status(request,username=request.user.username)
    # messages.debug(request, 'debug')
    # messages.info(request, 'Mensajes para usuari@s')
    # messages.success(request, 'success')
    # messages.warning(request, 'warning')
    # messages.error(request, 'error')
    return TemplateResponse(request, 'baseajax.html', contexto)


@login_required
def index_no_ajax(request):
    contexto = {'usuarios': get_current_users()}
    contexto['status'] = user_status(request,username=request.user.username)
    # messages.debug(request, 'debug')
    # messages.info(request, 'Mensajes para usuari@s')
    # messages.success(request, 'success')
    # messages.warning(request, 'warning')
    # messages.error(request, 'error')
    return TemplateResponse(request, 'pages/index.html', contexto)
#    return TemplateResponse(request, 'baseajax.html', contexto)


@login_required
def load_index(request):
    if request.is_ajax():
        context = dict()
        if request.method == 'GET':
            context['usuarios'] = get_current_users()
            context['status'] = user_status(request, username=request.user.username)
        else:
            HttpResponseBadRequest(u'El método no está permitido')
        return TemplateResponse(request, 'partials/_index.html', context)
    else:
        raise Http404(u'Lo siento, pero esto es una vista AJAX.')


@login_required
def load_sidebar(request):
    if request.is_ajax():
        data = dict()
        if request.method == 'GET':
            context = {}
            data['html'] = render_to_string('componentes/sidebar.html', context, request=request)
        else:
            data['error'] = u'El método no está autorizado'
        return JsonResponse(data)
    else:
        raise Http404(u'Lo siento, pero esto es una vista AJAX.')


@login_required
def about(request):
    contexto = {}
    # messages.debug(request, 'debug')
    # messages.info(request, 'info')
    # messages.success(request, 'success')
    # messages.warning(request, 'warning')
    # messages.error(request, 'error')
    return TemplateResponse(request, 'pages/about.html', contexto)
