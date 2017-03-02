/**
 * Created by fmoras01 on 2/02/17.
 */

$(function () {

  /* Functions */

  var loadForm = function () {
    var btn = $(this);
    $.ajax({
      url: btn.attr("data-url"),
      type: 'get',
      dataType: 'json',
      beforeSend: function () {
        $("#modal-alumno").modal("show");
      },
      success: function (data) {
        $("#modal-alumno .modal-content").html(data.html_form);
      }
    });
  };

  var saveForm = function () {
    var form = $(this);
    $.ajax({
      url: form.attr("action"),
      data: form.serialize(),
      type: form.attr("method"),
      dataType: 'json',
      success: function (data) {
        if (data.form_is_valid) {
          $("#alumnos-table tbody").html(data.html_alumno_list);
          $("#modal-alumno").modal("hide");
        }
        else {
          $("#modal-alumno .modal-content").html(data.html_form);
        }
      }
    });
    return false;
  };


  //* Binding */

  // Create Alumno
  $(".js-create-alumno").click(loadForm);
  $("#modal-alumno").on("submit", ".js-alumno-create-form", saveForm);

  // Update Alumno
  $("#alumnos-table").on("click", ".js-update-alumno", loadForm);
  $("#modal-alumno").on("submit", ".js-alumno-update-form", saveForm);


  // Siguiente página
  $("")

});
