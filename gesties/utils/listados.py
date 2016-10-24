from io import BytesIO

from django.http import HttpResponse, Http404
from django.contrib.auth.decorators import login_required

from reportlab.platypus import SimpleDocTemplate, Paragraph, TableStyle, PageTemplate, Frame
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.lib import colors
from reportlab.lib.units import cm
from reportlab.lib.pagesizes import A4
from reportlab.platypus import Table
from reportlab.graphics import shapes
import labels

from gesties.grupos.models import CursoGrupoAlumno


@login_required
def listin_telefonico(request, curso):
    alumnos = CursoGrupoAlumno.objects.filter(curso_grupo__curso_id=curso).order_by('alumno')
    if len(alumnos) == 0:
        raise Http404
    # Create the HttpResponse object with the appropriate PDF headers.
    response = HttpResponse(content_type='application/pdf')
    #response['Content-Disposition'] = 'attachment; filename="listin.pdf"'
    response['Content-Disposition'] = 'filename="listin.pdf"'

    def inicio_pagina(canvas, document):
        canvas.saveState()
        canvas.setFont('Times-Roman', 19)
        canvas.drawString(cm, 0.75 * cm, "Página %d" % doc.page)
        canvas.restoreState()

    # Create the PDF object, using the response object as its "file."
    buff = BytesIO()
    pageTemplate = PageTemplate(onPage=inicio_pagina)
    doc = SimpleDocTemplate(buff,
                            pagesize=A4,
                            rightMargin=10,
                            leftMargin=20,
                            topMargin=20,
                            bottomMargin=10,
                            )
    pdf = []
    styles = getSampleStyleSheet()
    header = Paragraph("Curso: "+str(alumnos[0].curso_grupo.curso)+" Listado Telefónico de Alumno/as", styles['Title'])
    pdf.append(header)
    headings = ('Apellidos', 'Nombre','DNI','Foto','Expediente','Teléfonos')
    todosalumnos = [(alumno.alumno.apellidos, alumno.alumno.nombre, alumno.alumno.dni,
                     alumno.alumno.foto,alumno.alumno.expediente,
                     alumno.alumno.telefono) for alumno in alumnos]
    t = Table([headings] + todosalumnos)
    #t = Table(todosalumnos)

    t.setStyle(TableStyle(
        [
            ('GRID', (0, 0), (3, -1), 1, colors.dodgerblue),
            ('LINEBELOW', (0, 0), (-1, 0), 2, colors.darkblue),
            ('BACKGROUND', (0, 0), (-1, 0), colors.dodgerblue)
        ]
    ))
    pdf.append(t)
    doc.addPageTemplates([pageTemplate])
    doc.build(pdf)
    response.write(buff.getvalue())
    buff.close()
    return response


@login_required
def etiquetas_alumnos(request, curso):
    alumnos = CursoGrupoAlumno.objects.filter(curso_grupo__curso_id=curso).order_by('alumno')
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
