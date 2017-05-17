from django.core.exceptions import PermissionDenied


def ajax_required(f):
    def wrap(request, *args, **kwargs):
        if not request.is_ajax():
            return PermissionDenied

        return f(request, *args, **kwargs)

    wrap.__doc__ = f.__doc__
    wrap.__name__ = f.__name__
    return wrap


def administrativo_or_responsable_required(f):
    def wrap(request, *args, **kwargs):
        if not request.session['esResponsable'] or not request.session['esAdministrativo']:
            return PermissionDenied

        return f(request, *args, **kwargs)

    wrap.__doc__ = f.__doc__
    wrap.__name__ = f.__name__
    return wrap


def responsable_required(f):
    def wrap(request, *args, **kwargs):
        if not request.session['esResponsable']:
            return PermissionDenied

        return f(request, *args, **kwargs)

    wrap.__doc__ = f.__doc__
    wrap.__name__ = f.__name__
    return wrap


def administrativo_required(f):
    def wrap(request, *args, **kwargs):
        if not request.session['esAdministrativo']:
            return PermissionDenied

        return f(request, *args, **kwargs)

    wrap.__doc__ = f.__doc__
    wrap.__name__ = f.__name__
    return wrap
