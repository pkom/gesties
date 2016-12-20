# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals
import json

from django.core import serializers


class serializer(object):

    def __init__(self, instance):
        self.instance = instance

    def serializer(self):
        return json.loads(serializers.serialize('json', [self.instance, ]))[0]
