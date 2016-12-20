# -*- coding: utf-8 -*-
from io import BytesIO

from django.http import HttpResponse, Http404
from django.contrib.auth.decorators import login_required

from reportlab.platypus import BaseDocTemplate, PageTemplate, Frame
from reportlab.platypus.flowables import Flowable
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.lib.units import cm
from reportlab.graphics import shapes
import labels

from gesties.cursos.models import Curso
from gesties.grupos.models import CursoGrupoAlumno
from gesties.configies.models import Configies


class EntradaListin(Flowable):

    def __init__(self, size=None, alumno=None):
        if size is None: size=2.6*cm
        #self.xoffset = xoffset
        self.size = size
        # normal size is 4 inches
        #self.scale = size/(4.0*cm)
        self.alumno = alumno

    def wrap(self, *args):
        return (0, self.size)

    def draw(self):
        canvas = self.canv
        canvas.roundRect(0, 0, 500, self.size, radius=4)
        if self.alumno.alumno.foto:
            canvas.drawImage(self.alumno.alumno.foto.path, 5, 15, 40, 45)
        tutores = self.alumno.alumno.tutores.all()
        l = 0
        for tutor in tutores:
            canvas.setFont("Helvetica", size=10)
            canvas.drawString(50, 5 + l, "Tutor Legal:")
            canvas.setFont("Helvetica-Bold", size=10)
            canvas.drawString(105, 5 + l, str(tutor))
            canvas.setFont("Helvetica", size=10)
            canvas.drawString(340, 5 + l, "Teléfonos:")
            canvas.setFont("Helvetica-Bold", size=10)
            canvas.drawString(390, 5 + l, tutor.telefono1 + '/' + tutor.telefono2)
            l += 10

        canvas.setFont("Helvetica", size = 10)
        canvas.drawString(50, 45 + l, "Alumno/a:")
        canvas.setFont("Helvetica-Bold", size = 10)
        canvas.drawString(105, 45 + l, str(self.alumno.alumno))
        canvas.setFont("Helvetica", size = 10)
        canvas.drawString(415, 45 + l, "Grupo:")
        canvas.setFont("Helvetica-Bold", size = 10)
        canvas.drawString(450, 45 + l, str(self.alumno.curso_grupo.grupo))
        canvas.setFont("Helvetica", size = 10)
        canvas.drawString(50, 35 + l, "Expediente:")
        canvas.setFont("Helvetica-Bold", size = 10)
        canvas.drawString(105, 35 + l, self.alumno.alumno.expediente)
        canvas.setFont("Helvetica", size = 10)
        canvas.drawString(135, 35 + l, "Fecha Nac.:")
        canvas.setFont("Helvetica-Bold", size = 10)
        canvas.drawString(190, 35 + l, self.alumno.alumno.fecha_nacimiento.strftime('%d/%m/%Y'))
        canvas.setFont("Helvetica", size = 10)
        canvas.drawString(245, 35 + l, "D.N.I.:")
        canvas.setFont("Helvetica-Bold", size = 10)
        canvas.drawString(275, 35 + l, self.alumno.alumno.dni)
        canvas.setFont("Helvetica", size = 10)
        canvas.drawString(340, 35 + l, "N.I.E.:")
        canvas.setFont("Helvetica-Bold", size = 10)
        canvas.drawString(370, 35 + l, self.alumno.alumno.nie)
        canvas.setFont("Helvetica", size = 10)
        canvas.drawString(50, 25 + l, "Teléfonos:")
        canvas.setFont("Helvetica-Bold", size = 10)
        canvas.drawString(105, 25 + l, self.alumno.alumno.telefono)
        canvas.setFont("Helvetica", size = 10)
        canvas.drawString(50, 15 + l, "Dirección:")
        canvas.setFont("Helvetica-Bold", size = 10)
        canvas.drawString(105, 15 + l, self.alumno.alumno.direccion + ' ' + self.alumno.alumno.localidad + ' (' +
                                   self.alumno.alumno.codigo_postal + ') ' + self.alumno.alumno.provincia)
        canvas.setFont("Helvetica", size=10)
        canvas.drawString(50, 5 + l, "Tutor Grup:")
        canvas.setFont("Helvetica-Bold", size=10)
        canvas.drawString(105, 5 + l, str(self.alumno.curso_grupo.tutor))


@login_required
def listin_telefonico(request, curso=None, grupo=None):
    if not curso:
        curso = request.session.get('curso_academico').get('pk')
    else:
        curso_qs = Curso.objects.filter(slug=curso)
        if curso_qs:
            curso = curso_qs[0].id
        else:
            raise Http404
    alumnos = CursoGrupoAlumno.objects.filter(curso_grupo__curso_id=curso).order_by('alumno')
    if grupo:
        alumnos = alumnos.filter(curso_grupo__grupo__grupo=grupo).order_by('alumno')
    if len(alumnos) == 0:
        raise Http404
    # Create the HttpResponse object with the appropriate PDF headers.
    response = HttpResponse(content_type='application/pdf')
    #response['Content-Disposition'] = 'attachment; filename="listin.pdf"'
    response['Content-Disposition'] = 'filename="listin.pdf"'
    # Create the PDF object, using the response object as its "file."
    buff = BytesIO()
    styles = getSampleStyleSheet()
    Elements = []
    doc = BaseDocTemplate(buff, leftMargin = 2 * cm, rightMargin = 0.5 * cm,
                          topMargin = 2 * cm, bottomMargin = 1 * cm, showBoundary=0)
    cabecera1 = request.session.get('centro', Configies.objects.all()[0].nombre_centro)
    cabecera2 = "Curso "+str(alumnos[0].curso_grupo.curso)+" - Listado telefónico de alumno/as " + (("- Grupo: "+grupo) if grupo else "")
    def cabeceraYpie(canvas, doc):
        canvas.saveState()
        canvas.setFont('Helvetica-Bold', 14)
        canvas.drawCentredString(21 * cm / 2, 29 * cm, cabecera1)
        canvas.drawCentredString(21 * cm / 2, 28 * cm, cabecera2)
        canvas.setFont('Times-Roman', 10)
        canvas.drawCentredString(21 * cm /2, cm, "Página {}".format(doc.page))
        canvas.restoreState()
    # normal frame as for SimpleFlowDocument
    frameT = Frame(doc.leftMargin, doc.bottomMargin, doc.width, doc.height, id='normal')
    for alumno in alumnos:
        Elements.append(EntradaListin(alumno=alumno))
    doc.addPageTemplates([PageTemplate(id='OneCol', frames=frameT, onPage=cabeceraYpie)])
    # start the construction of the pdf
    doc.build(Elements)
    response.write(buff.getvalue())
    buff.close()
    return response


@login_required
def etiquetas_alumnos(request, curso=None, grupo=None):
    if not curso:
        curso = request.session.get('curso_academico').get('pk')
    else:
        curso_qs = Curso.objects.filter(slug=curso)
        if curso_qs:
            curso = curso_qs[0].id
        else:
            raise Http404
    alumnos = CursoGrupoAlumno.objects.filter(curso_grupo__curso_id=curso).order_by('alumno')
    if grupo:
        alumnos = alumnos.filter(curso_grupo__grupo__grupo=grupo).order_by('alumno')
    if len(alumnos) == 0:
        raise Http404
    # Create the HttpResponse object with the appropriate PDF headers.
    response = HttpResponse(content_type='application/pdf')
    #response['Content-Disposition'] = 'attachment; filename="listin.pdf"'
    response['Content-Disposition'] = 'filename="etiquetas.pdf"'
    buff = BytesIO()
    # Create an A4 portrait (210mm x 297mm) sheets with 2 columns and 8 rows of
    # labels. Each label is 90mm x 25mm with a 2mm rounded corner. The margins are
    # automatically calculated.
    specs = labels.Specification(210, 297, 1, 14, 185, 19, corner_radius=2,
                                 left_margin=20, top_margin=20, bottom_margin=10)

    # Create a function to draw each label. This will be given the ReportLab drawing
    # object to draw on, the dimensions (NB. these will be in points, the unit
    # ReportLab uses) of the label, and the object to render.
    def draw_label(label, width, height, obj):
        # Just convert the object to a string and print this at the bottom left of
        # the label.
        #print("Generando etiqueta de {}".format(obj.alumno))
        label.add(shapes.String(50, 40, "Apellidos:", fontName="Helvetica", fontSize=10))
        label.add(shapes.String(100, 40, obj.alumno.apellidos, fontName="Helvetica-Bold", fontSize=10))
        label.add(shapes.String(50, 30, "Nombre:", fontName="Helvetica", fontSize=10))
        label.add(shapes.String(100, 30, obj.alumno.nombre, fontName="Helvetica-Bold", fontSize=10))
        label.add(shapes.String(50, 20, "Tfnos.:", fontName="Helvetica", fontSize=10))
        label.add(shapes.String(100, 20, obj.alumno.telefono, fontName="Helvetica-Bold", fontSize=10))
        label.add(shapes.String(50, 10, "Dirección:", fontName="Helvetica", fontSize=10))
        label.add(shapes.String(100, 10, obj.alumno.direccion+' '+obj.alumno.localidad+' ('+obj.alumno.codigo_postal+
                                ') '+obj.alumno.provincia,
                                fontName="Helvetica-Bold", fontSize=10))
        tutores = obj.alumno.tutores.all()
        l = 0
        for tutor in tutores:
            label.add(shapes.String(200, 40-l, "Tutor:", fontName="Helvetica", fontSize=10))
            label.add(shapes.String(230, 40-l, str(tutor), fontName="Helvetica-Bold", fontSize=10))
            label.add(shapes.String(390, 40-l, "Tfnos:", fontName="Helvetica", fontSize=10))
            label.add(shapes.String(420, 40-l, tutor.telefono1+'/'+tutor.telefono2,
                                    fontName="Helvetica-Bold", fontSize=10))
            l += 10
        label.add(shapes.String(230, 20, "Fecha Nac.:", fontName="Helvetica", fontSize=10))
        label.add(shapes.String(290, 20, obj.alumno.fecha_nacimiento.strftime('%d/%m/%Y'), fontName="Helvetica-Bold", fontSize=10))
        label.add(shapes.String(345, 20, "Expediente:", fontName="Helvetica", fontSize=10))
        label.add(shapes.String(400, 20, obj.alumno.expediente, fontName="Helvetica-Bold", fontSize=10))
        label.add(shapes.String(430, 20, "D.N.I.:", fontName="Helvetica", fontSize=10))
        label.add(shapes.String(460, 20, obj.alumno.dni, fontName="Helvetica-Bold", fontSize=10))
        if obj.alumno.foto:
            label.add(shapes.Image(5,5,40,40,obj.alumno.foto.path))
        label.add(shapes.String(420, 5, 'Grupo:',fontName="Helvetica", fontSize=12))
        label.add(shapes.String(460, 5, str(obj.curso_grupo.grupo), fontName="Helvetica-Bold", fontSize=12))
        label.add(shapes.String(50, 2, 'Tutor grupo:', fontName="Helvetica", fontSize=8))
        label.add(shapes.String(100, 2, str(obj.curso_grupo.tutor), fontName="Helvetica-Bold", fontSize=8))
        label.add(shapes.String(230, 2, "N.I.E.:", fontName="Helvetica", fontSize=8))
        label.add(shapes.String(260, 2, obj.alumno.nie, fontName="Helvetica-Bold", fontSize=8))

    # Create the sheet.
    sheet = labels.Sheet(specs, draw_label, border=True)

    #for alumno in alumnos:
    #    sheet.add_label(alumno)
    sheet.add_labels(alumnos)

    # Add a couple of labels.
    #sheet.add_label("Hello")
    #sheet.add_label("World")

    # We can also add each item from an iterable.
    #sheet.add_labels(range(3, 22))

    # Note that any oversize label is automatically trimmed to prevent it messing up
    # other labels.
    #sheet.add_label("Oversized label here")
    sheet.save(buff)
    # Save the file and we are done.
    response.write(buff.getvalue())
    buff.close()
    #print("{0:d} label(s) output on {1:d} page(s).".format(sheet.label_count, sheet.page_count))
    return response
