# -*- coding: utf-8 -*-

from django.contrib.sessions.models import Session
from django.utils import timezone
from django.contrib.auth import get_user_model

def get_current_users():
    active_sessions = Session.objects.filter(expire_date__gte=timezone.now())
    user_id_list = []
    for session in active_sessions:
        data = session.get_decoded()
        user_id_list.append(data.get('_auth_user_id', None))
    # Query all logged in users based on id list
    return get_user_model().objects.filter(id__in=user_id_list)
