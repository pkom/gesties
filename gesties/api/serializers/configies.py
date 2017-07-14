# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from rest_framework import serializers

from gesties.configies.models import Configies


class ConfigiesSerializer(serializers.ModelSerializer):

    class Meta:
        model = Configies
        fields = ('id', 'codigo_centro', 'nombre_centro', 'url_centro', 'email_centro', 'direccion_centro',
        'telefono_centro', 'fax_centro', 'curso_defecto', 'nombre_director', 'firma_director', 'logo_centro',
        'sello_centro')
