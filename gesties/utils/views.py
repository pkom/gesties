# -*- coding: utf-8 -*-

from django.contrib.auth.decorators import login_required
from django.template.response import TemplateResponse
from django.contrib import messages

from gesties.utils.users import get_current_users

@login_required
def index(request):
    contexto = {'usuarios': get_current_users()}
    # messages.debug(request, 'debug')
    # messages.info(request, 'info')
    # messages.success(request, 'success')
    # messages.warning(request, 'warning')
    # messages.error(request, 'error')
    return TemplateResponse(request, 'pages/index.html', contexto)

@login_required
def about(request):
    contexto = {}
    # messages.debug(request, 'debug')
    # messages.info(request, 'info')
    # messages.success(request, 'success')
    # messages.warning(request, 'warning')
    # messages.error(request, 'error')
    return TemplateResponse(request, 'pages/about.html', contexto)
