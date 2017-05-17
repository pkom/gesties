from django.db.models import Q
from django.contrib.auth.models import Group

from rest_framework import permissions


class IsResponsableOrAdministrativo(permissions.BasePermission):
    """
    Permission.
    Allow permissions to Responsable or Administrativo users
    """
    message = u'Sólo se permite el acceso a usuarios del grupo Responsable o Administrativo.'

    def has_permission(self, request, view):

        grupos = Group.objects.filter(Q(name='administrativos') | Q(name='responsables'))
        return request.user.groups.all().filter(pk__in=grupos).exists()
