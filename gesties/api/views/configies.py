# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from rest_framework import generics
from rest_framework.permissions import AllowAny

from gesties.configies.models import Configies
from gesties.api.serializers.configies import ConfigiesSerializer


# lista de configies
class ConfigiesList(generics.ListAPIView):
    permission_classes = [AllowAny, ]
    queryset = Configies.objects.all()
    serializer_class = ConfigiesSerializer

