# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals
import os, os.path, shutil
import xml.sax.handler

from django.core.files import File
from django.contrib import admin

from gesties.utils.zip import descomprime
from gesties.users.models import User
from gesties.alumnos.models import Alumno
from gesties.departamentos.models import Departamento, CursoDepartamento, CursoDepartamentoProfesor
from gesties.grupos.models import Grupo, CursoGrupo, CursoGrupoAlumno, CursoGrupoProfesor
from .models import Rayuela


def import_data(modeladmin, request, queryset):

    class ProfesorHandler(xml.sax.handler.ContentHandler):

        def __init__(self, request, queryset):
            self.buffer = ""
            self.inField = 0
            self.modeladmin = modeladmin
            self.request = request
            self.queryset = queryset
            self.resultado = u'<h5>Resultado del proceso</h5>'

        def get_resultado(self):
            return self.resultado

        def startElement(self, name, attrs):
            if name == "dni":
                self.inField = 1
            elif name == "nombre":
                self.inField = 1
            elif name == "primer-apellido":
                self.inField = 1
            elif name == "segundo-apellido":
                self.inField = 1
            elif name == "es-usuario":
                self.inField = 1
            elif name == "login":
                self.inField = 1
            elif name == "id-usuario":
                self.inField = 1
            elif name == "departamento":
                self.inField = 1
            elif name == "grupos":
                self.grupos = []
            elif name == "grupo":
                self.inField = 1

        def characters(self, data):
            if self.inField:
                self.buffer += data

        def endElement(self, name):
            if name == "profesor":
                updated_values = {
                    'dni' : self.dni,
                    'es_usuario': self.esusuario,
                    'usuario_rayuela': self.login,
                    'id_usuario': self.idusuario,
                    'first_name': self.nombre,
                    'last_name': '%s %s' % (self.primerapellido, self.segundoapellido),
                    'is_staff': True,
                    'is_active': True
                }
                user, created = User.objects.update_or_create(username=self.login, defaults=updated_values)
                self.resultado += u'<ul>Procesando profesor %s %s, %s' % (self.primerapellido, self.segundoapellido,
                                                                            self.nombre)
                if created:
                    self.resultado += u'<li>Se ha creado el profesor %s</li>' % (user)
                #veamos si existe el profesor en el curso
                curso = self.queryset[0].curso
                #cursoprofesor, created = CursoProfesor.objects.get_or_create(profesor=profe, curso=curso)
                #if created:
                #    self.resultado += u'<li>Se ha asignado %s al curso %s</li>' % (profe, curso)
                if self.departamento:
                    departamento, created = Departamento.objects.get_or_create(departamento=self.departamento)
                    if created:
                        self.resultado += u'<li>Se ha creado el departamento %s</li>' % (departamento)
                    cursodepartamento, created = CursoDepartamento.objects.get_or_create(departamento=departamento,
                                                                                         curso=curso)
                    if created:
                        self.resultado += u'<li>Se ha creado el departamento %s en el curso %s</li>' % (departamento, curso)
                    cursodepartamentoprofesor, created = CursoDepartamentoProfesor.objects.get_or_create(curso_departamento=cursodepartamento,
                                                                                               profesor=user)
                    if created:
                        self.resultado += u'<li>Se ha asignado el profesor %s al departamento %s en el curso %s</li>' %\
                                        (user, cursodepartamento, curso)
                if self.grupos:
                    for grupoit in self.grupos:
                        grupo, created = Grupo.objects.get_or_create(grupo=grupoit)
                        if created:
                            self.resultado += u'<li>Se ha creado el grupo %s</li>' % (grupo)
                        cursogrupo, created = CursoGrupo.objects.get_or_create(grupo=grupo, curso=curso)
                        if created:
                            self.resultado += u'<li>Se ha creado el grupo %s en el curso %s</li>' % (grupo, curso)
                        cursogrupoprofesor, created = CursoGrupoProfesor.objects.get_or_create(curso_grupo=cursogrupo,
                                                                                    profesor=user)
                        if created:
                            self.resultado += u'<li>Se ha asignado el profesor %s al grupo %s en el curso %s</li>' %\
                                            (cursogrupoprofesor, cursogrupo, curso)
                self.resultado += u'</ul>'
            elif name == "dni":
                self.inField = 0
                self.dni = self.buffer
            elif name == "nombre":
                self.inField = 0
                self.nombre = self.buffer
            elif name == "primer-apellido":
                self.inField = 0
                self.primerapellido = self.buffer
            elif name == "segundo-apellido":
                self.inField = 0
                self.segundoapellido = self.buffer
            elif name == "es-usuario":
                self.inField = 0
                if self.buffer == "true":
                    self.esusuario = True
                else:
                    self.esusuario = False
            elif name == "login":
                self.inField = 0
                self.login = self.buffer
            elif name == "id-usuario":
                self.inField = 0
                self.idusuario = self.buffer
            elif name == "departamento":
                self.inField = 0
                self.departamento = self.buffer
            elif name == "grupo":
                self.inField = 0
                self.grupo = self.buffer
                self.grupos.append(self.grupo)

            self.buffer = ""


    class AlumnoHandler(xml.sax.handler.ContentHandler):

        def __init__(self, request, queryset, dirname):
            self.buffer = ""
            self.inField = 0
            self.modeladmin = modeladmin
            self.request = request
            self.queryset = queryset
            self.dirname = dirname
            self.resultado = u'<h5>Resultado del proceso</h5>'

        def get_resultado(self):
            return self.resultado

        def startElement(self, name, attrs):
            if name == "nie":
                self.inField = 1
            elif name == "nombre":
                self.inField = 1
            elif name == "primer-apellido":
                self.inField = 1
            elif name == "segundo-apellido":
                self.inField = 1
            elif name == "fecha-nacimiento":
                self.inField = 1
            elif name == "es-usuario":
                self.inField = 1
            elif name == "login":
                self.inField = 1
            elif name == "id-usuario":
                self.inField = 1
            elif name == 'con-foto':
                self.inField = 1
            elif name == 'formato':
                self.inField = 1
            elif name == 'nombre-fichero':
                self.inField = 1
            elif name == "grupo":
                self.inField = 1

        def characters(self, data):
            if self.inField:
                self.buffer += data

        def endElement(self, name):
            if name == "alumno":
                updated_values = {
                    'nombre': self.nombre,
                    'apellidos': '%s %s' % (self.primerapellido, self.segundoapellido),
                    'fecha_nacimiento': self.fechanacimiento,
                    'usuario_rayuela': self.login
                }
                if self.nombrefichero:
                    ficherofoto = os.path.join(self.dirname, self.nombrefichero)
                    #updated_values['foto'] = File(open(ficherofoto))
                alumno, created = Alumno.objects.update_or_create(nie=self.nie, defaults=updated_values)
                self.resultado += u'<ul>Procesando alumno %s' % (alumno)
                if created:
                    self.resultado += u'<li>Se ha creado el alumno %s</li>' % (alumno)
                alumno.save()
                curso = self.queryset[0].curso
                if self.grupo:
                    grupo, created = Grupo.objects.get_or_create(grupo=self.grupo)
                    if created:
                        self.resultado += u'<li>Se ha creado el grupo %s</li>' % (grupo)
                    cursogrupo, created = CursoGrupo.objects.get_or_create(grupo=grupo, curso=curso)
                    if created:
                        self.resultado += u'<li>Se ha creado el grupo %s en el curso %s</li>' % (grupo, curso)
                    cursogrupoalumno, created = CursoGrupoAlumno.objects.get_or_create(curso_grupo=cursogrupo,
                                                                                alumno=alumno)
                    if created:
                        self.resultado += u'<li>Se ha asignado el alumno %s al grupo %s en el curso %s</li>' %\
                                        (alumno, cursogrupo, curso)
                self.resultado += u'</ul>'
            elif name == "nie":
                self.inField = 0
                self.nie = self.buffer
            elif name == "nombre":
                self.inField = 0
                self.nombre = self.buffer
            elif name == "primer-apellido":
                self.inField = 0
                self.primerapellido = self.buffer
            elif name == "segundo-apellido":
                self.inField = 0
                self.segundoapellido = self.buffer
            elif name == "fecha-nacimiento":
                self.inField = 0
                self.fechanacimiento = self.buffer[-4:]+'-'+self.buffer[3:5]+'-'+self.buffer[0:2]
            elif name == "es-usuario":
                self.inField = 0
                if self.buffer == "true":
                    self.esusuario = True
                else:
                    self.esusuario = False
            elif name == "login":
                self.inField = 0
                self.login = self.buffer
            elif name == "id-usuario":
                self.inField = 0
                self.idusuario = self.buffer
            elif name == "grupo":
                self.inField = 0
                self.grupo = self.buffer
            elif name == 'con-foto':
                self.inField = 0
                if self.buffer == "true":
                    self.confoto = True
                else:
                    self.confoto = False
            elif name == 'formato':
                self.inField = 0
                self.formato = self.buffer
            elif name == 'nombre-fichero':
                self.inField = 0
                self.nombrefichero = self.buffer

            self.buffer = ""


    for rayuela in queryset:
        parser = xml.sax.make_parser()
        if rayuela.tipo == 'PR':
            handler = ProfesorHandler(request, queryset)
            parser.setContentHandler(handler)
            parser.parse(rayuela.archivo.path)
        elif rayuela.tipo == 'AL':
            temp = descomprime(rayuela.archivo.path)
            handler = AlumnoHandler(request, queryset, temp)
            parser.setContentHandler(handler)
            parser.parse(os.path.join(temp, 'Alumnos.xml'))
            try:
                shutil.rmtree(temp)
            except:
                pass
        rayuela.resultado = handler.get_resultado()
        rayuela.procesado = True
        rayuela.save()


import_data.short_description = 'Importa datos desde Rayuela'


@admin.register(Rayuela)
class RayuelaAdmin(admin.ModelAdmin):
    list_display = ['curso', 'tipo', 'archivo', 'created', 'modified', 'procesado']
    readonly_fields = ['procesado', 'resultado_html',]
    exclude = ('resultado',)
    actions = [import_data]