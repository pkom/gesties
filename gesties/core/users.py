# -*- coding: utf-8 -*-

from django.contrib.sessions.models import Session
from django.utils import timezone
from django.contrib.auth import get_user_model

from gesties.configies.models import Configies
from gesties.users.models import User
from gesties.cursos.models import Curso
from gesties.departamentos.models import CursoDepartamento, CursoDepartamentoProfesor
from gesties.grupos.models import CursoGrupo, CursoGrupoProfesor, CursoGrupoAlumno, CursoProfesor


def get_current_users():

    active_sessions = Session.objects.filter(expire_date__gte=timezone.now())
    user_id_list = []
    for session in active_sessions:
        data = session.get_decoded()
        user_id_list.append(data.get('_auth_user_id', None))
    # Query all logged in users based on id list
    return get_user_model().objects.filter(id__in=user_id_list)


# obtener datos de un usuario en concreto y un determinado curso
class user_status(object):

    def __init__(self, request, username=None, curso=None):
        if not curso:
            if 'curso_academico' in request.session.keys():
                self.curso = Curso.objects.filter(id=request.session['curso_academico']['pk']).first()
            else:
                self.curso = Curso.objects.filter(id=Configies.objects.all().first().curso_defecto.id)
        else:
            self.curso = Curso.objects.filter(id=curso).first() or None
        if request.user.is_authenticated and not username:
            self.curso_profesor = request.session['cursoprofesor']['pk']
            self.user = request.user
        elif username:
            self.curso_profesor = CursoProfesor.objects.filter(curso=self.curso, profesor__username=username).first() or None
        if self.curso_profesor:
            self.user = self.curso_profesor.profesor
            self.jefaturas = self.curso_profesor.jefaturas.all() #CursoDepartamento.objects.filter(jefe=self.curso_profesor, curso=self.curso)
            self.tutorias = self.curso_profesor.tutorias.all() #CursoGrupo.objecsts.filter(tutor=self.curso_profesor, curso=self.curso)
            self.grupos = self.curso_profesor.grupos.all() #CursoGrupoProfesor.objects.filter(curso_profesor=self.curso_profesor, curso_grupo__curso=self.curso)
            self.departamentos = self.curso_profesor.departamentos.all() #CursoDepartamentoProfesor.objects.filter(curso_profesor=self.curso_profesor, curso_departamento__curso=self.curso)
        else:
            self.user = User.objects.filter(username=username).first() or None
            self.jefaturas = CursoDepartamento.objects.none()
            self.tutorias = CursoGrupo.objects.none()
            self.grupos = CursoGrupoProfesor.objects.none()
            self.departamentos = CursoDepartamentoProfesor.objects.none()

    def es_responsable(self):
        if self.user.groups.filter(name='responsables').exists():
            return True
        else:
            return False

    def es_administrativo(self):
        if self.user.groups.filter(name='administrativos').exists():
            return True
        else:
            return False

    def es_jefe(self):
        if self.jefaturas.exists():
            return True
        else:
            return False

    def get_jefaturas(self):
        return self.jefaturas

    def es_tutor(self):
        if self.tutorias.exists():
            return True
        else:
            return False

    def get_tutorias(self):
        return self.tutorias

    def get_grupos(self):
        return self.grupos

    def get_departamentos(self):
        return self.departamentos



# obtener datos de un alumno en un curso
class student_status(object):

    def __init__(self, request, nie=None, curso=None):
        if not curso:
            self.curso = Curso.objects.filter(id=request.session['curso_academico']['pk']).first() or None
        else:
            self.curso = Curso.objects.filter(id=curso).first() or None
        self.curso_grupo_alumno = CursoGrupoAlumno.objects.filter(curso_alumno__alumno__nie=nie)

    def get_grupos(self):
        return self.curso_grupo_alumno

    def get_alumno(self):
        return self.curso_grupo_alumno.first().curso_alumno.alumno
