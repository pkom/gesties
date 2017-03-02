# -*- coding: utf-8 -*-

from django.http import HttpResponse, Http404
from django.template.loader import render_to_string


class AJAXListMixin(object):

     def dispatch(self, request, *args, **kwargs):
         if not request.is_ajax():
             raise Http404("Esto es una vista AJAX, amigo.")
         return super(AJAXListMixin, self).dispatch(request, *args, **kwargs)
