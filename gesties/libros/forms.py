# -*- coding: utf-8 -*-

from django import forms
from django.forms import inlineformset_factory
from django.forms.fields import ValidationError
from django.urls import reverse

from .models import Libro, Ejemplar, Prestamo


class LibroForm(forms.ModelForm):
    prestados = forms.IntegerField(label='Ejemplares prestados', required=False)
    bajas = forms.IntegerField(label='Ejemplares dados de baja', required=False)
    disponibles = forms.IntegerField(label='Ejemplares disponibles', required=False)
    deteriorados = forms.IntegerField(label='Ejemplares deteriorados', required=False)
    alta_autor = forms.CharField(label='Nuevo autor/a (sólo si no existe)', required=False, max_length=150)
    alta_editorial = forms.CharField(label='Nueva editorial (sólo si no existe)', required=False, max_length=150)
    alta_area = forms.CharField(label='Nueva área (sólo si no existe)', required=False, max_length=150)
    alta_nivel = forms.IntegerField(label='Nuevo nivel (sólo si no existe)', required=False)
    alta_ciclo = forms.CharField(label='Nuevo ciclo (sólo si no existe)', required=False, max_length=50)
    alta_descripcion_ciclo = forms.CharField(label='Nuevo ciclo descripción (sólo si no existe)', required=False,
                                             max_length=150)
    class Meta:

        model = Libro
        fields = ('titulo', 'autor', 'alta_autor', 'editorial', 'alta_editorial', 'anio_edicion', 'area_conocimiento',
                  'alta_area', 'isbn', 'codigo_barras', 'nivel', 'alta_nivel', 'alta_ciclo', 'alta_descripcion_ciclo',
                  'numero_ejemplares', 'precio', 'fecha_inicio', 'fecha_fin'
        )

    def __init__(self, *args, **kwargs):
        super(LibroForm, self).__init__(*args, **kwargs)
        self.fields['autor'].empty_label = u'Escoge un/a autor/a'
        self.fields['editorial'].empty_label = u'Escoge la editorial'
        self.fields['area_conocimiento'].empty_label = u'Escoge área de conocimiento'
        self.fields['nivel'].empty_label = u'Escoge el nivel'
        instance = getattr(self, 'instance', None)
        if instance.pk:
            self.fields['bajas'].initial = instance.bajas
            self.fields['prestados'].initial = instance.prestados
            self.fields['disponibles'].initial = instance.disponibles
            self.fields['deteriorados'].initial = instance.deteriorados

    def clean_codigo_barras(self):
        codigo_barras = self.cleaned_data.get('codigo_barras')
        libro = getattr(self, 'instance', None)
        if libro.pk is None:
            if Libro.objects.filter(codigo_barras=codigo_barras).count() > 0:
                raise ValidationError('El código de barras ya está usado por otro libro')
        return codigo_barras

    def clean_numero_ejemplares(self):
        numero_ejemplares = self.cleaned_data.get('numero_ejemplares')
        libro = getattr(self, 'instance', None)
        if libro and libro.pk:
            if numero_ejemplares < libro.ejemplar_set.all().count():
                raise ValidationError('Para eliminar ejemplares debes usar el formulario de ejemplares')
        return numero_ejemplares


# validating formset
class CustomLibroInlineFormset(forms.BaseInlineFormSet):
    def clean(self):
        super(CustomLibroInlineFormset, self).clean()
        if any(self.errors):
            return
        for form in self.deleted_forms:
            # controlaremos que no se puedan borrar ejemplares prestados o con movimientos
            if form.cleaned_data.get("estado") == Ejemplar.PRESTADO:
                raise forms.ValidationError("No se pueden eliminar ejemplares prestados")
            if form.instance.prestamo_set.all().exists():
                raise forms.ValidationError("No se pueden eliminar ejemplares con movimientos anteriores")
        #codigos_barras = []
        #for form in self.forms:
            # hay que comprobar los models que han cambiado para la validación de prestado
            # no se puede cambiar a prestado ningún ejemplar
            # si estaba prestado no se puede cambiar a otro estado
            # no se puede cambiar a baja si estaba prestado
            # no borrar si está prestado o ha tenido algún movimiento de préstamo
            #if form.cleaned_data.get("estado") == Ejemplar.PRESTADO:
            #    raise forms.ValidationError("No se puede marcar un ejemplar como prestado desde este formulario")

            # no se pueden guardar ejemplares con el mismo código de barras,
            # lo siguiente es innecesario porque el modelo ya controla la excepción unique
            #codigo_barras = form.cleaned_data.get('codigo_barras')
            #if codigo_barras in codigos_barras:
            #    raise forms.ValidationError("Los códigos de barras de los ejemplares deben ser diferentes")
            #codigos_barras.append(codigo_barras)


class EjemplarForm(forms.ModelForm):

    class Meta:
        model = Ejemplar
        fields = ('codigo_barras', 'estado')
        error_messages = {
            "codigo_barras": {
                "unique": "Ya existe un ejemplar con este código de barras",
            }

        }

    def clean(self):
        codigo_barras = self.cleaned_data.get('codigo_barras')
        estado = self.cleaned_data.get('estado')
        if self.instance.pk:
            if (codigo_barras == '' or codigo_barras != self.instance.codigo_barras) and estado == Ejemplar.PRESTADO:
                raise forms.ValidationError('No se puede cambiar el código de barras del ejemplar ya prestado')

    def clean_estado(self):
        estado_nuevo = self.cleaned_data.get('estado')
        ejemplar = self.instance
        if ejemplar.pk:
            if estado_nuevo == Ejemplar.DISPONIBLE and ejemplar.estado == Ejemplar.PRESTADO:
                raise forms.ValidationError('Para marcar como disponible el ejemplar utilice las opciones de préstamo')
            if estado_nuevo == Ejemplar.PRESTADO and ejemplar.estado != estado_nuevo:
                raise forms.ValidationError('Para prestar el ejemplar utilice las opciones de préstamo')
            if estado_nuevo == Ejemplar.BAJA or estado_nuevo == Ejemplar.DETERIORADO:
                if ejemplar.estado == Ejemplar.PRESTADO:
                    raise forms.ValidationError('Para dar de baja o marcar como deteriorado el ejemplar debe estar disponible')
        return estado_nuevo


LibroFormSet = inlineformset_factory(Libro, Ejemplar, form=EjemplarForm, extra=1, formset=CustomLibroInlineFormset)


class PrestamoModelForm(forms.ModelForm):

    class Meta:

        model = Prestamo
        fields = ('ejemplar', 'curso_grupo_alumno')


class PrestamoManualForm(forms.Form):

    curso_grupo = forms.ChoiceField(label='Grupo')
    curso_grupo_alumno = forms.ChoiceField(label='Alumno/a')
    libros_alumno_pendientes = forms.ChoiceField(label='Libros Pendientes del Alumno/a')
    ejemplares_libro = forms.ChoiceField(label='Ejemplares Disponibles Del Libro')
    ejemplares_prestados = forms.ChoiceField(label='Ejemplares De Libros Prestados')

    def __init__(self, request, *args, **kwargs):
        super(PrestamoManualForm, self).__init__(*args, **kwargs)
        self.fields['curso_grupo'].widget = forms.Select({
            'class': 'form-control',
            'data-curso': request.session['curso_academico']['pk'],
            'data-url': reverse('api:grupos-list'),
            'data-placeholder' : 'Elige un grupo...',
        })

        self.fields['curso_grupo_alumno'].widget = forms.Select({
            'class': 'form-control',
            'data-url': reverse('api:alumnos-grupo-list'),
            'data-placeholder' : 'Elige un alumno/a...',
        })
        self.fields['curso_grupo_alumno'].disabled = True

        self.fields['libros_alumno_pendientes'].widget = forms.Select({
            'class': 'form-control',
            'data-url': reverse('api:alumnos-libros-pendientes-list'),
            'data-placeholder' : 'Elige un libro...',
        })
        self.fields['libros_alumno_pendientes'].disabled = True

        self.fields['ejemplares_libro'].widget = forms.Select({
            'class': 'form-control',
            'data-url': reverse('api:libros-ejemplares-disponibles-list'),
            'data-url-movimiento': reverse('api:libros-alumno-prestar'),
            'data-placeholder' : 'Elige un ejemplar para prestar...',
            #'size': '10',
            #'multiple': 'multiple'
        })
        self.fields['ejemplares_libro'].disabled = True

        self.fields['ejemplares_prestados'].widget = forms.Select({
            'class': 'form-control',
            'data-url': reverse('api:alumnos-libros-prestados-list'),
            'data-url-movimiento': reverse('api:libros-alumno-devolver'),
            'data-placeholder' : 'Elige los ejemplares para devolver...',
            #'size': '10',
            'multiple': 'multiple'
        })
        self.fields['ejemplares_prestados'].disabled = True


class PrestamoAutomaticoForm(forms.Form):

    curso_grupo = forms.ChoiceField()
    curso_grupo_alumno = forms.ChoiceField()
    tipo_movimiento = forms.ChoiceField()
    ejemplares_prestados = forms.ChoiceField()
    codigo_barras = forms.CharField()


    def __init__(self, request, *args, **kwargs):
        super(PrestamoAutomaticoForm, self).__init__(*args, **kwargs)
        self.fields['curso_grupo'].widget = forms.Select({
            'class': 'form-control',
            'data-curso': request.session['curso_academico']['pk'],
            'data-url': reverse('api:grupos-list'),
            'data-placeholder' : 'Elige un grupo...',
        })

        self.fields['curso_grupo_alumno'].widget = forms.Select({
            'class': 'form-control',
            'data-url': reverse('api:alumnos-grupo-list'),
            'data-placeholder' : 'Elige un alumno/a...',
        })
        self.fields['curso_grupo_alumno'].disabled = True

        self.fields['tipo_movimiento'].widget = forms.Select({
            'class': 'form-control',
            'data-placeholder' : 'Tipo de movimiento...',
        })

        self.fields['tipo_movimiento'].choices = (
            ('P', u'Préstamo'),
            ('D', u'Devolución'),
        )


        self.fields['ejemplares_prestados'].widget = forms.Select({
            'class': 'form-control',
            'data-url': reverse('api:alumnos-libros-prestados-list'),
            'size': '5',
            'multiple': 'multiple'
        })

        self.fields['codigo_barras'].widget = forms.TextInput({
            'class': 'form-control',
            'data-url-prestamo': reverse('api:libros-alumno-prestar'),
            'data-url-devolucion': reverse('api:libros-alumno-devolver'),
        })


class ImprimeCBForm(forms.ModelForm):
    choices = [(i, i) for i in range(1, 30)]
    ancho = forms.ChoiceField(label='Etiquetas ancho de página', initial=3, choices=choices)
    alto = forms.ChoiceField(label='Etiquetas alto de página', initial=11 , choices=choices)
    inicio = forms.ChoiceField(label='Primera etiqueta a imprimir', initial=1, choices=choices)
    ejemplares = forms.ModelMultipleChoiceField(label='Ejemplares para imprimir etiquetas', queryset=None)
    nautor = forms.CharField(label='Autor/a')

    class Meta:
        model = Libro
        fields = ('titulo', )

    def __init__(self, *args, **kwargs):
        super(ImprimeCBForm, self).__init__(*args, **kwargs)
        self.fields['nautor'].initial = self.instance.autor.autor
        self.fields['ejemplares'].queryset=self.instance.ejemplar_set

    def clean(self):
        if self.cleaned_data.get('inicio') > self.cleaned_data.get('ancho') * self.cleaned_data.get('alto'):
            forms.ValidationError('El inicio no puede ser mayor de '+self.cleaned_data.get('ancho')+'*'+self.cleaned_data.get('alto'))
