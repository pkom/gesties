/**
 * Created by fmoras01 on 2/03/17.
 */

$(function () {

    $(".page-content-area").ace_ajax({
        content_url: function(hash) {
    		return hash;
        },
        default_url: '/inicio/index',
        loading_icon: "fa fa-spin fa-spinner fa-2x orange",
        loading_overlay: '.page-content',
        //loading_text: 'Cargando datos del servidor...',
    });



});
