/**
 * Created by fmoras01 on 2/03/17.
 */

jQuery(function ($) {

    $( document ).ajaxStart(function() {
        $('.page-content-area').ace_ajax('startLoading');
    });

    $( document ).ajaxComplete(function() {
        $('.page-content-area').ace_ajax('stopLoading', true);
    });


    $.fn.aceAjax.defaults = $.fn.ace_ajax.defaults = {
        content_url: function(hash) {
  				return hash;

        },
        default_url: '/inicio/index',
		loading_icon: 'fa fa-spin fa-spinner fa-2x orange',
		loading_text: '',
		loading_overlay: '.page-content',
		update_breadcrumbs: true,
		update_title: true,
		update_active: true,
		close_active: true,
		max_load_wait: false,
		close_mobile_menu: false,
		close_dropdowns: true
     };


    $('.page-content-area').ace_ajax();

    $(window).on('error.ace_ajax', function() {
        $('.page-content-area').each(function() {
            var $this = $(this);
            if( $this.ace_ajax('working') ) {
                if(window.Pace && Pace.running) Pace.stop();
                $this.ace_ajax('stopLoading', true);
            }
        })
    });


});
