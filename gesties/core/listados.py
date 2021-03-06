# -*- coding: utf-8 -*-
from io import BytesIO, StringIO
import re

from django.http import HttpResponse, Http404
from django.contrib.auth.decorators import login_required
from django.db import connection

from reportlab.lib import colors
from reportlab.lib.enums import TA_CENTER, TA_RIGHT
from reportlab.platypus import BaseDocTemplate, PageTemplate, Frame, TableStyle
from reportlab.platypus.flowables import Flowable
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.graphics import shapes
from reportlab.graphics.barcode.widgets import BarcodeCode128
from reportlab.graphics.barcode import getCodes, getCodeNames, createBarcodeDrawing
from reportlab.graphics.shapes import Drawing
from reportlab.graphics import renderPDF
from reportlab.platypus import SimpleDocTemplate, Table, Paragraph
from reportlab.lib.pagesizes import landscape, A4
from reportlab.lib.units import mm, cm
from reportlab.pdfbase.pdfmetrics import stringWidth
import labels

from gesties.cursos.models import Curso
from gesties.grupos.models import CursoGrupoAlumno
from gesties.configies.models import Configies
from gesties.libros.models import Nivel, Libro, Ejemplar


class EntradaListin(Flowable):
    def __init__(self, size=None, alumno=None):
        if size is None: size = 2.6 * cm
        # self.xoffset = xoffset
        self.size = size
        # normal size is 4 inches
        # self.scale = size/(4.0*cm)
        self.alumno = alumno

    def wrap(self, *args):
        return (0, self.size)

    def draw(self):
        canvas = self.canv
        canvas.roundRect(0, 0, 500, self.size, radius=4)
        if self.alumno.curso_alumno.alumno.foto:
            try:
                canvas.drawImage(self.alumno.curso_alumno.alumno.foto.path, 5, 15, 40, 45)
            except:
                pass
        tutores = self.alumno.curso_alumno.alumno.tutores.all()
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

        canvas.setFont("Helvetica", size=10)
        canvas.drawString(50, 45 + l, "Alumno/a:")
        canvas.setFont("Helvetica-Bold", size=10)
        canvas.drawString(105, 45 + l, str(self.alumno.curso_alumno.alumno))
        canvas.setFont("Helvetica", size=10)
        canvas.drawString(415, 45 + l, "Grupo:")
        canvas.setFont("Helvetica-Bold", size=10)
        canvas.drawString(450, 45 + l, str(self.alumno.curso_grupo.grupo))
        canvas.setFont("Helvetica", size=10)
        canvas.drawString(50, 35 + l, "Expediente:")
        canvas.setFont("Helvetica-Bold", size=10)
        canvas.drawString(105, 35 + l, self.alumno.curso_alumno.alumno.expediente)
        canvas.setFont("Helvetica", size=10)
        canvas.drawString(135, 35 + l, "Fecha Nac.:")
        canvas.setFont("Helvetica-Bold", size=10)
        canvas.drawString(190, 35 + l, self.alumno.curso_alumno.alumno.fecha_nacimiento.strftime('%d/%m/%Y'))
        canvas.setFont("Helvetica", size=10)
        canvas.drawString(245, 35 + l, "D.N.I.:")
        canvas.setFont("Helvetica-Bold", size=10)
        canvas.drawString(275, 35 + l, self.alumno.curso_alumno.alumno.dni)
        canvas.setFont("Helvetica", size=10)
        canvas.drawString(340, 35 + l, "N.I.E.:")
        canvas.setFont("Helvetica-Bold", size=10)
        canvas.drawString(370, 35 + l, self.alumno.curso_alumno.alumno.nie)
        canvas.setFont("Helvetica", size=10)
        canvas.drawString(50, 25 + l, "Teléfonos:")
        canvas.setFont("Helvetica-Bold", size=10)
        canvas.drawString(105, 25 + l, self.alumno.curso_alumno.alumno.telefono)
        canvas.setFont("Helvetica", size=10)
        canvas.drawString(50, 15 + l, "Dirección:")
        canvas.setFont("Helvetica-Bold", size=10)
        canvas.drawString(105, 15 + l,
                          self.alumno.curso_alumno.alumno.direccion + ' ' + self.alumno.curso_alumno.alumno.localidad + ' (' +
                          self.alumno.curso_alumno.alumno.codigo_postal + ') ' + self.alumno.curso_alumno.alumno.provincia)
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
    alumnos = CursoGrupoAlumno.objects.filter(curso_grupo__curso_id=curso).order_by('curso_alumno__alumno')
    if grupo:
        alumnos = alumnos.filter(curso_grupo__grupo__grupo=grupo).order_by('curso_alumno__alumno')
    if len(alumnos) == 0:
        raise Http404
    # Create the HttpResponse object with the appropriate PDF headers.
    response = HttpResponse(content_type='application/pdf')
    # response['Content-Disposition'] = 'attachment; filename="listin.pdf"'
    response['Content-Disposition'] = 'filename="listin.pdf"'
    # Create the PDF object, using the response object as its "file."
    buff = BytesIO()
    styles = getSampleStyleSheet()
    Elements = []
    doc = BaseDocTemplate(buff, leftMargin=2 * cm, rightMargin=0.5 * cm,
                          topMargin=2 * cm, bottomMargin=1 * cm, showBoundary=0)
    cabecera1 = request.session.get('centro', Configies.objects.all()[0].nombre_centro)
    cabecera2 = "Curso " + str(alumnos[0].curso_grupo.curso) + " - Listado telefónico de alumno/as " + (
    ("- Grupo: " + grupo) if grupo else "")

    def cabeceraYpie(canvas, doc):
        canvas.saveState()
        canvas.setFont('Helvetica-Bold', 14)
        canvas.drawCentredString(21 * cm / 2, 29 * cm, cabecera1)
        canvas.drawCentredString(21 * cm / 2, 28 * cm, cabecera2)
        canvas.setFont('Times-Roman', 10)
        canvas.drawCentredString(21 * cm / 2, cm, "Página {}".format(doc.page))
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
    alumnos = CursoGrupoAlumno.objects.filter(curso_grupo__curso_id=curso).order_by('curso_alumno__alumno')
    if grupo:
        alumnos = alumnos.filter(curso_grupo__grupo__grupo=grupo).order_by('curso_alumno__alumno')
    if len(alumnos) == 0:
        raise Http404
    # Create the HttpResponse object with the appropriate PDF headers.
    response = HttpResponse(content_type='application/pdf')
    # response['Content-Disposition'] = 'attachment; filename="listin.pdf"'
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
        # print("Generando etiqueta de {}".format(obj.alumno))
        label.add(shapes.String(50, 40, "Apellidos:", fontName="Helvetica", fontSize=10))
        label.add(shapes.String(100, 40, obj.curso_alumno.alumno.apellidos, fontName="Helvetica-Bold", fontSize=10))
        label.add(shapes.String(50, 30, "Nombre:", fontName="Helvetica", fontSize=10))
        label.add(shapes.String(100, 30, obj.curso_alumno.alumno.nombre, fontName="Helvetica-Bold", fontSize=10))
        label.add(shapes.String(50, 20, "Tfnos.:", fontName="Helvetica", fontSize=10))
        label.add(shapes.String(100, 20, obj.curso_alumno.alumno.telefono, fontName="Helvetica-Bold", fontSize=10))
        label.add(shapes.String(50, 10, "Dirección:", fontName="Helvetica", fontSize=10))
        label.add(shapes.String(100, 10, obj.curso_alumno.alumno.direccion + ' ' + obj.curso_alumno.alumno.localidad +
                                ' (' + obj.curso_alumno.alumno.codigo_postal +
                                ') ' + obj.curso_alumno.alumno.provincia,
                                fontName="Helvetica-Bold", fontSize=10))
        tutores = obj.curso_alumno.alumno.tutores.all()
        l = 0
        for tutor in tutores:
            label.add(shapes.String(200, 40 - l, "Tutor:", fontName="Helvetica", fontSize=10))
            label.add(shapes.String(230, 40 - l, str(tutor), fontName="Helvetica-Bold", fontSize=10))
            label.add(shapes.String(390, 40 - l, "Tfnos:", fontName="Helvetica", fontSize=10))
            label.add(shapes.String(420, 40 - l, tutor.telefono1 + '/' + tutor.telefono2,
                                    fontName="Helvetica-Bold", fontSize=10))
            l += 10
        label.add(shapes.String(230, 20, "Fecha Nac.:", fontName="Helvetica", fontSize=10))
        label.add(shapes.String(290, 20, obj.curso_alumno.alumno.fecha_nacimiento.strftime('%d/%m/%Y'),
                                fontName="Helvetica-Bold", fontSize=10))
        label.add(shapes.String(345, 20, "Expediente:", fontName="Helvetica", fontSize=10))
        label.add(shapes.String(400, 20, obj.curso_alumno.alumno.expediente, fontName="Helvetica-Bold", fontSize=10))
        label.add(shapes.String(430, 20, "D.N.I.:", fontName="Helvetica", fontSize=10))
        label.add(shapes.String(460, 20, obj.curso_alumno.alumno.dni, fontName="Helvetica-Bold", fontSize=10))
        if obj.curso_alumno.alumno.foto:
            try:
                label.add(shapes.Image(5, 5, 40, 40, obj.curso_alumno.alumno.foto.path))
            except:
                pass
        label.add(shapes.String(420, 5, 'Grupo:', fontName="Helvetica", fontSize=12))
        label.add(shapes.String(460, 5, str(obj.curso_grupo.grupo), fontName="Helvetica-Bold", fontSize=12))
        label.add(shapes.String(50, 2, 'Tutor grupo:', fontName="Helvetica", fontSize=8))
        label.add(shapes.String(100, 2, str(obj.curso_grupo.tutor), fontName="Helvetica-Bold", fontSize=8))
        label.add(shapes.String(230, 2, "N.I.E.:", fontName="Helvetica", fontSize=8))
        label.add(shapes.String(260, 2, obj.curso_alumno.alumno.nie, fontName="Helvetica-Bold", fontSize=8))

    # Create the sheet.
    sheet = labels.Sheet(specs, draw_label, border=True)

    # for alumno in alumnos:
    #    sheet.add_label(alumno)
    sheet.add_labels(alumnos)

    # Add a couple of labels.
    # sheet.add_label("Hello")
    # sheet.add_label("World")

    # We can also add each item from an iterable.
    # sheet.add_labels(range(3, 22))

    # Note that any oversize label is automatically trimmed to prevent it messing up
    # other labels.
    # sheet.add_label("Oversized label here")
    sheet.save(buff)
    # Save the file and we are done.
    response.write(buff.getvalue())
    buff.close()
    # print("{0:d} label(s) output on {1:d} page(s).".format(sheet.label_count, sheet.page_count))
    return response


def imprime_cb_ejemplares(request):
    # , ejemplares, ancho=3, alto=8, inicio=1):
    # se le pasa por get la lista de ejemplares, el ancho, alto y la etiqueta de inicio
    if request.method == 'POST':
        # para PDFs
        if 'pdf' in request.POST:
            titulo = request.POST.get('titulo')
            autor = request.POST.get('nautor')
            ancho = int(request.POST.get('ancho'))
            alto = int(request.POST.get('alto'))
            inicio = int(request.POST.get('inicio'))
            lejemplares = request.POST.getlist('ejemplares')
            qs_ejemplares = Ejemplar.objects.filter(pk__in=lejemplares)
            ejemplares = []
            for ejemplar in qs_ejemplares:
                ejemplares.append(ejemplar.codigo_barras)

            # Create the HttpResponse object with the appropriate PDF headers.
            response = HttpResponse(content_type='application/pdf')
            filename = 'EjemplaresCBs'
            response['Content-Disposition'] = 'filename={0}.pdf'.format(filename)
            buff = BytesIO()
            # Create an A4 portrait (210mm x 297mm) sheets with 3 columns and 11 rows of
            # labels. Each label is 70mm x 25mm. The margins are automatically calculated.
            specs = labels.Specification(210, 297, ancho, alto,
                                         (210 / ancho),
                                         ((297 - 9 - 8) / alto),
                                         top_margin=9, bottom_margin=8,
                                         left_margin=0, right_margin=0,
                                         right_padding=0, left_padding=0,
                                         top_padding=0, bottom_padding=0)

            # Create a function to draw each label. This will be given the ReportLab drawing
            # object to draw on, the dimensions (NB. these will be in points, the unit
            # ReportLab uses) of the label, and the object to render.
            def draw_label(label, width, height, obj):
                # https://github.com/d-e-e-p/generate_nametags_with_barcodes/blob/master/generate_nametags_with_barcodes.py
                pad = 10

                # section 1 : barcode
                # D = Drawing(width, height)
                # d = createBarcodeDrawing('Code128', value=obj, width=50*mm, barHeight=15 * mm, humanReadable=True)
                d = createBarcodeDrawing('Code128', value=obj, width=width * 2 / 3, barHeight=height * 5 / 9,
                                         humanReadable=True)

                # d = createBarcodeDrawing('I2of5', value=the_num,  barHeight=10*mm, humanReadable=True)

                barcode_width = d.width
                barcode_height = d.height

                # d.rotate(-90)
                d.translate(- barcode_height, pad)  # translate

                d.translate(width - barcode_width - pad / 2, 0)  # translate

                # import pprint
                # pprint(d.dumpProperties())

                # D.add(d)
                # label.add(D)
                label.add(d)

                '''
                # Measure the width of the name and shrink the font size until it fits.
                # try out 2 options and select the one that gives a taller font
                text_width_limit = width - barcode_width - pad
                text_height_limit = height / 2.0
                font_name = 'Helvetica'
                s1 = fit_text_in_area(datos['titulo'], font_name, text_width_limit, text_height_limit)

                text_width_limit = width - pad
                text_height_limit = height - barcode_height
                s2 = fit_text_in_area(datos['titulo'], font_name, text_width_limit, text_height_limit)

                if (s1.fontSize >= s2.fontSize):
                    s = s1
                else:
                    s = s2

                s.x = pad / 2.0
                s.y = height - s.fontSize + pad / 2.0
                s.textAnchor = "start"

                label.add(s)

                title_name_height = get_font_height(s.fontSize, datos['titulo'])
                title_name_width = stringWidth(datos['titulo'], font_name, s.fontSize)

                # section3: author name
                text_width_limit = width - barcode_width - 2 * pad
                text_height_limit = (height - title_name_height) / 2.0
                #font_name = "Judson Bold"

                s = fit_text_in_area(datos['autor'], font_name, text_width_limit, text_height_limit)
                s.x = pad / 2.0
                s.y = height - title_name_height - s.fontSize + pad / 2.0
                s.textAnchor = "start"

                label.add(s)
                '''

                shape_titulo = shapes.String(20, 0, titulo, fontSize=8)
                shape_titulo.y = height - 10
                shape_titulo.textAnchor = "start"
                label.add(shape_titulo)

                # josé no quiere autor
                # shape_autor = shapes.String(15, 0, autor, fontSize=6)
                # shape_autor.y = height - 20
                # shape_autor.textAnchor = "start"
                # label.add(shape_autor)

                # label.add(shapes.String(15, 60, titulo, fontSize=8))
                # label.add(shapes.String(15, 50, autor, fontSize=8))


                # barcode_image_raw = barcode.createBarcodeImageInMemory('Code128', value=obj, width=150 * mm, height=30 * mm)
                # cb = Image.open(BytesIO(barcode_image_raw))
                # cb.save("cb.png")
                # label.add(shapes.Image(5, 15, width=150, height=30, path="cb.png"))
                # label.add(shapes.String(40, 5, obj))

            # Create the sheet.
            sheet = labels.Sheet(specs, draw_label, border=False)
            # Mark some of the labels on the first page as already used.
            blancos = []
            for i in range(1, inicio):
                fila, col = divmod(i, ancho)
                b = [fila + 1 if col != 0 else fila, col if col != 0 else ancho]
                blancos.append(b)
            sheet.partial_page(1, blancos)
            sheet.add_labels(ejemplares)
            sheet.save(buff)
            # Save the file and we are done.
            response.write(buff.getvalue())
            buff.close()
            return response


# ----------------------------------------------------------------------
# adjust fontsize down until it fits a width/height limit
# should really range for value instead of timidly crepping towards target
# ----------------------------------------------------------------------
def fit_text_in_area(the_text, font_name, text_width_limit, text_height_limit):
    font_size = text_height_limit
    text_width = stringWidth(the_text, font_name, font_size)
    while ((text_width > text_width_limit) or (font_size > text_height_limit)):
        font_size *= 0.95
        text_width = stringWidth(the_text, font_name, font_size)

    s = shapes.String(0, 0, the_text, fontName=font_name, fontSize=font_size, textAnchor="start")
    # pprint("text_height_limit = " + str(text_height_limit))
    # pprint(s.dumpProperties())
    # pprint(s)
    return s


# ----------------------------------------------------------------------
# adjust str height if there are any low-hanging letters (ie decenders)
# ----------------------------------------------------------------------
def get_font_height(size, str):
    pattern = re.compile(r'[gjpqy]')
    if pattern.findall(str):
        size *= 1.1
    return size


class BarCode(Flowable):
    # Based on http://stackoverflow.com/questions/18569682/use-qrcodewidget-or-plotarea-with-platypus
    def __init__(self, value="1234567890", ratio=0.5):
        # init and store rendering value
        Flowable.__init__(self)
        self.value = value
        self.ratio = ratio

    def wrap(self, availWidth, availHeight):
        # Make the barcode fill the width while maintaining the ratio
        self.width = availWidth
        self.height = self.ratio * availWidth
        return self.width, self.height

    def draw(self):
        # Flowable canvas
        bar_code = BarcodeCode128(value=self.value)
        # bar_code = Ean13BarcodeWidget(value=self.value)
        bounds = bar_code.getBounds()
        bar_width = bounds[2] - bounds[0]
        bar_height = bounds[3] - bounds[1]
        w = float(self.width)
        h = float(self.height)
        d = Drawing(w, h, transform=[w / bar_width, 0, 0, h / bar_height, 0, 0])
        d.add(bar_code)
        renderPDF.draw(d, self.canv, 0, 0)


def imprime_cb_ejemplares_1(request, titulo=None, autor=None, ancho=None, alto=None, inicio=None, ejemplares=None):
    # , ejemplares, ancho=3, alto=8, inicio=1):
    # se le pasa por get la lista de ejemplares, el ancho, alto y la etiqueta de inicio
    if request.method == 'GET':
        # para PDFs
        if 'pdf' in request.GET:
            datos = {}
            datos['titulo'] = request.GET.get('titulo')
            datos['autor'] = request.GET.get('nautor')
            datos['ancho'] = int(request.GET.get('ancho'))
            datos['alto'] = int(request.GET.get('alto'))
            datos['inicio'] = int(request.GET.get('inicio'))
            ejemplares = request.GET.getlist('ejemplares')
            qs_ejemplares = Ejemplar.objects.filter(pk__in=ejemplares)
            datos['ejemplares'] = []
            for i in range(1, datos['inicio']):
                datos['ejemplares'].append('')

            for ejemplar in qs_ejemplares:
                datos['ejemplares'].append(ejemplar.codigo_barras)
            # Create the HttpResponse object with the appropriate PDF headers.
            response = HttpResponse(content_type='application/pdf')
            pdf_name = "etiquetas.pdf"
            response['Content-Disposition'] = 'filename={0}.pdf'.format(pdf_name)
            buff = BytesIO()
            doc = SimpleDocTemplate(buff, pagesize=A4, leftMargin=10, rightMargin=10, topMargin=25, bottomMargin=20,
                                    showBoundary=1)
            (ancho_pagina, largo_pagina) = A4
            styleSheet = getSampleStyleSheet()
            iCols = datos['ancho']
            iRows = round(len(datos['ejemplares']) / iCols)
            iRowsPerPage = largo_pagina / datos['alto'] + 10
            table_data = [[[] for col in range(iCols)] for row in range(iRows)]
            iCells = len(datos['ejemplares'])
            texto1 = Paragraph('Hola', styleSheet["BodyText"])
            texto2 = Paragraph('Adios', styleSheet["BodyText"])
            for i in range(iCells):
                fila, col = divmod(i, iCols)
                if i + 1 >= datos['inicio']:
                    table_data[fila][col].append(BarCode(value=datos['ejemplares'][i]))

            # table_data = [[BarCode(value='0600670100030001'), BarCode(value='0600670100030002'), BarCode(value='0600670100030003')],
            #               [BarCode(value='0600670100030004'), BarCode(value='0600670100030005'), BarCode(value='0600670100030006')],
            #               [BarCode(value='0600670100030007'), BarCode(value='0600670100030008'), BarCode(value='0600670100030009')],
            #               [BarCode(value='0600670100030010'), BarCode(value='0600670100030011'), BarCode(value='0600670100030012')],
            #               [BarCode(value='0600670100030013'), BarCode(value='0600670100030014'), BarCode(value='0600670100030015')],
            #               [BarCode(value='0600670100030016'), BarCode(value='0600670100030017'), BarCode(value='0600670100030018')],
            #               [BarCode(value='0600670100030019'), BarCode(value='0600670100030020'), BarCode(value='0600670100030021')],
            #               [BarCode(value='0600670100030022'), BarCode(value='0600670100030023'), BarCode(value='0600670100030024')],
            #               [BarCode(value='0600670100030025'), BarCode(value='0600670100030026'), BarCode(value='0600670100030027')],
            #               ]
            barcode_table = Table(table_data, colWidths=[ancho_pagina / iCols] * iCols,
                                  rowHeights=[iRowsPerPage] * iRows)

            parts = []
            parts.append(barcode_table)
            doc.build(parts)
            response.write(buff.getvalue())
            buff.close()
            return response


def imprime_libros(request, orden=None):
    def cabecera_pie(canvas, doc):
        canvas.saveState()
        styles = getSampleStyleSheet()
        styles.add(ParagraphStyle(name='TitCentrado', alignment=TA_CENTER, parent=styles['Heading1']), alias='CENT')
        centro = request.session.get('centro', Configies.objects.all()[0].nombre_centro)
        header = Paragraph(centro + ' - ' + "Informe de Libros de Texto", styles['TitCentrado'])
        w, h = header.wrap(doc.width, doc.topMargin)
        header.drawOn(canvas, doc.leftMargin, doc.height + doc.topMargin - h)
        styles.add(ParagraphStyle(name='Paginador', alignment=TA_RIGHT, parent=styles['Normal']), alias='PAG')
        footer = Paragraph("Página {}".format(doc.page), styles['Paginador'])
        w, h = footer.wrap(doc.width, doc.bottomMargin)
        footer.drawOn(canvas, doc.leftMargin, h)

    qslibros = Libro.objects.all().order_by('titulo')
    if orden:
        qslibros = Libro.objects.all().order_by('nivel', 'titulo')

    if len(qslibros) == 0:
        raise Http404
    # Create the HttpResponse object with the appropriate PDF headers.
    response = HttpResponse(content_type='application/pdf')
    # response['Content-Disposition'] = 'attachment; filename="libros.pdf"'
    response['Content-Disposition'] = 'filename="libros.pdf"'
    # Create the PDF object, using the response object as its "file."
    buff = BytesIO()
    doc = SimpleDocTemplate(buff, pagesize=landscape(A4), leftMargin=1 * cm, rightMargin=1 * cm,
                            topMargin=2 * cm, bottomMargin=1 * cm)
    libros = []
    headings = ('Título', 'Autor', 'Editorial', 'Año', 'Área', 'Nivel', 'Precio', 'Total', 'Prest',
                'Disp', 'Bajas', 'Deter', 'Inicio', 'Fin')
    todoslibros = [(l.titulo[:46], l.autor.autor[:9], l.editorial.editorial[:9], l.anio_edicion, l.area_conocimiento,
                    "{} {}".format(l.nivel.nivel, l.nivel.ciclo.ciclo),
                    l.precio, l.numero_ejemplares, l.prestados, l.disponibles, l.bajas, l.deteriorados,
                    l.fecha_inicio.isoformat(), l.fecha_fin.isoformat()) for l in qslibros]
    t = Table([headings] + todoslibros, colWidths=[8 * cm, 2 * cm, 2 * cm, 1.2 * cm, 1.2 * cm, 1.2 * cm, 1.2 * cm,
                                                   1 * cm, 1 * cm, 1 * cm, 1 * cm, 1 * cm, 2 * cm, 2 * cm],
              repeatRows=1)
    t.setStyle(TableStyle(
        [
            ('FONTSIZE', (0, 0), (-1, -1), 8),
            # ('GRID', (0, 0), (13, -1), 1, colors.dodgerblue),
            ('LINEBELOW', (0, 0), (-1, 0), 1, colors.darkblue),
            ('LINEBELOW', (0, 1), (-1, -1), 1, colors.black),
            ('LINEBEFORE', (0, 1), (0, -1), 1, colors.black),
            ('LINEAFTER', (-1, 1), (-1, -1), 1, colors.black),
            ('BACKGROUND', (0, 0), (-1, 0), colors.dodgerblue),
            ('ALIGN', (6, 0), (-3, -1), 'RIGHT')
        ]
    ))
    libros.append(t)
    doc.build(libros, onFirstPage=cabecera_pie, onLaterPages=cabecera_pie)
    response.write(buff.getvalue())
    buff.close()
    return response


def imprime_ejemplares_prestados(request):
    def cabecera_pie(canvas, doc):
        canvas.saveState()
        styles = getSampleStyleSheet()
        styles.add(ParagraphStyle(name='TitCentrado', alignment=TA_CENTER, parent=styles['Heading1']), alias='CENT')
        centro = request.session.get('centro', Configies.objects.all()[0].nombre_centro)
        curso = request.session.get('curso', request.session["curso_academico"]["fields"]["curso"])
        prestados = request.session.get('prestados', '0')
        header = Paragraph(centro + ' - ' + "Informe de Préstamos de Libros" + ' - ' + curso + ' (' + str(prestados) +')', styles['TitCentrado'])
        w, h = header.wrap(doc.width, doc.topMargin)
        header.drawOn(canvas, doc.leftMargin, doc.height + doc.topMargin - h)
        styles.add(ParagraphStyle(name='Paginador', alignment=TA_RIGHT, parent=styles['Normal']), alias='PAG')
        footer = Paragraph("Página {}".format(doc.page), styles['Paginador'])
        w, h = footer.wrap(doc.width, doc.bottomMargin)
        footer.drawOn(canvas, doc.leftMargin, h)

    curso_id = request.session["curso_academico"]["pk"]
    tipo = request.GET.get('tipo', 'ordenaporalumno')

    if tipo == 'agrupaporalumno':
        SQL = ("SELECT " 
              "libros_libro.titulo, "
              "libros_nivel.nivel, "
              "libros_ciclo.ciclo, "
              "libros_ejemplar.codigo_barras, " 
              "libros_ejemplar.estado, " 
              "libros_prestamo.fecha_inicio_prestamo, " 
              "libros_prestamo.fecha_fin_prestamo, " 
              "alumnos_alumno.nombre, " 
              "alumnos_alumno.apellidos, " 
              "cursos_curso.curso, " 
              "grupos_grupo.grupo "
            "FROM " 
              "public.libros_prestamo, " 
              "public.libros_ejemplar, " 
              "public.libros_libro, "
              "public.libros_nivel, " 
              "public.libros_ciclo, "        
              "public.grupos_cursogrupoalumno, " 
              "public.grupos_cursogrupo, "  
              "public.alumnos_cursoalumno, " 
              "public.alumnos_alumno, " 
              "public.cursos_curso, " 
              "public.grupos_grupo "
            "WHERE " 
              "libros_prestamo.curso_grupo_alumno_id = grupos_cursogrupoalumno.id AND "
              "libros_ejemplar.id = libros_prestamo.ejemplar_id AND "
              "libros_libro.id = libros_ejemplar.libro_id AND "
              "libros_libro.nivel_id = libros_nivel.id AND "
              "libros_nivel.ciclo_id = libros_ciclo.id AND "        
              "grupos_cursogrupoalumno.curso_alumno_id = alumnos_cursoalumno.id AND "
              "grupos_cursogrupoalumno.curso_grupo_id = grupos_cursogrupo.id AND "
              "grupos_cursogrupo.grupo_id = grupos_grupo.id AND "
              "alumnos_cursoalumno.alumno_id = alumnos_alumno.id AND "
              "alumnos_cursoalumno.curso_id = cursos_curso.id AND "
              "cursos_curso.id = %s AND " 
              "libros_prestamo.fecha_fin_prestamo IS NULL " 
            "ORDER BY "
              "alumnos_alumno.apellidos ASC, " 
              "alumnos_alumno.nombre ASC, "
              "libros_libro.titulo ASC, " 
              "libros_ejemplar.codigo_barras ASC;"
               )
    else:
        SQL = ("SELECT " 
              "libros_libro.titulo, "
              "libros_nivel.nivel, "
              "libros_ciclo.ciclo, "                
              "libros_ejemplar.codigo_barras, " 
              "libros_ejemplar.estado, " 
              "libros_prestamo.fecha_inicio_prestamo, " 
              "libros_prestamo.fecha_fin_prestamo, " 
              "alumnos_alumno.nombre, " 
              "alumnos_alumno.apellidos, " 
              "cursos_curso.curso, " 
              "grupos_grupo.grupo "
            "FROM " 
              "public.libros_prestamo, " 
              "public.libros_ejemplar, " 
              "public.libros_libro, "
              "public.libros_nivel, " 
              "public.libros_ciclo, "         
              "public.grupos_cursogrupoalumno, " 
              "public.grupos_cursogrupo, "  
              "public.alumnos_cursoalumno, " 
              "public.alumnos_alumno, " 
              "public.cursos_curso, " 
              "public.grupos_grupo "        
            "WHERE " 
              "libros_prestamo.curso_grupo_alumno_id = grupos_cursogrupoalumno.id AND "
              "libros_ejemplar.id = libros_prestamo.ejemplar_id AND "
              "libros_libro.id = libros_ejemplar.libro_id AND "
              "libros_libro.nivel_id = libros_nivel.id AND "
              "libros_nivel.ciclo_id = libros_ciclo.id AND "        
              "grupos_cursogrupoalumno.curso_alumno_id = alumnos_cursoalumno.id AND "
              "grupos_cursogrupoalumno.curso_grupo_id = grupos_cursogrupo.id AND "
              "grupos_cursogrupo.grupo_id = grupos_grupo.id AND "
              "alumnos_cursoalumno.alumno_id = alumnos_alumno.id AND "
              "alumnos_cursoalumno.curso_id = cursos_curso.id AND "
              "cursos_curso.id = %s AND " 
              "libros_prestamo.fecha_fin_prestamo IS NULL " 
            "ORDER BY "
              "libros_nivel.nivel ASC, " 
              "libros_libro.titulo ASC, " 
              "libros_ejemplar.codigo_barras ASC, "        
              "alumnos_alumno.apellidos ASC, " 
              "alumnos_alumno.nombre ASC;"
               )

    #qs_ejemplares_prestados = Ejemplar.objects.filter(estado=Ejemplar.PRESTADO)\
    #    .order_by('libro__nivel__nivel', 'libro__titulo', 'codigo_barras')

    #qs_ejemplares_prestados = Ejemplar.objects.raw(SQL, [curso_id])
    ejemplares = []
    with connection.cursor() as cursor:
        cursor.execute(SQL, [curso_id])
        ejemplares = cursor.fetchall()
        request.session['prestados'] = len(ejemplares)

    # Create the HttpResponse object with the appropriate PDF headers.
    response = HttpResponse(content_type='application/pdf')
    # response['Content-Disposition'] = 'attachment; filename="libros.pdf"'
    response['Content-Disposition'] = 'filename="EjemplaresPrestados.pdf"'
    # Create the PDF object, using the response object as its "file."
    buff = BytesIO()
    doc = SimpleDocTemplate(buff, pagesize=landscape(A4), leftMargin=1.5 * cm, rightMargin=1.5 * cm,
                            topMargin=2 * cm, bottomMargin=1 * cm)
    libros = []
    headings = ('Nivel', 'Libro', 'Ejemplar', 'Estado', 'Fecha préstamo', 'Alumn@')
    #todosejemplares = [(l.libro.titulo, l.codigo_barras, l.alumno) for l in qs_ejemplares_prestados]
    todosejemplares = [ (str(ejemplar[1]) + '(' + ejemplar[2] + ')', ejemplar[0],  ejemplar[3], ejemplar[4], ejemplar[5].replace(tzinfo=None).isoformat(' ', 'minutes'), ejemplar[8] + ', ' + ejemplar[7] + ' (' + ejemplar[10] + ')') for ejemplar in ejemplares ]


    t = Table([headings] + todosejemplares, repeatRows=1)
    t.setStyle(TableStyle(
        [
            ('FONTSIZE', (0, 1), (-1, -1), 8),
            # ('GRID', (0, 0), (13, -1), 1, colors.dodgerblue),
            ('LINEBELOW', (0, 0), (-1, 0), 2, colors.darkblue),
            ('LINEBELOW', (0, 1), (-1, -1), 1, colors.black),
            ('LINEBEFORE', (0, 1), (0, -1), 1, colors.black),
            ('LINEAFTER', (-1, 1), (-1, -1), 1, colors.black),
            ('BACKGROUND', (0, 0), (-1, 0), colors.dodgerblue),
        ]
    ))
    libros.append(t)
    doc.build(libros, onFirstPage=cabecera_pie, onLaterPages=cabecera_pie)
    response.write(buff.getvalue())
    buff.close()
    return response
