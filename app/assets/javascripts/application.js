// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/autocomplete
//= require jquery.jcrop
//= require papercrop
//= require jquery-ui
//= require autocomplete-rails
//= require bootstrap-sprockets
//= require bootstrap-filestyle
//= require best_in_place
//= require jquery.purr
//= require best_in_place.purr
//= require turbolinks
//= require bootstrap
//= require nested_form_fields
//= require chosen-jquery
//= require autoresize.jquery
//= require jquery.stickytableheaders.min
//= require jquery.simple_cropper
//= require products


var invoker;

$.datepicker.setDefaults({
    dateFormat: 'dd-mm-yy'
});

$(document).ajaxError(function(event,xhr,options,exc) {
    
    var errors = JSON.parse(xhr.responseText);
    var kk ="<ul>";

    for(var i = 0; i < errors.length; i++){
        var list = errors[i];
        kk += "<li>"+list+"</li>"
    }
 
    kk +="</ul>"

    $("#error_explanation").html(kk);
       
});

// loader
function centerLoader() {
	var winW = $(window).width();
	var winH = $(window).height();

	var spinnerW = $('.fl').outerWidth();
	var spinnerH = $('.fl').outerHeight();

	$('.fl').css({
		'position':'absolute',
		'left':(winW/2)-(spinnerW/2),
		'top':(winH/2)-(spinnerH/2)
	});
}
function loader(on) {
	if (on) {
		$('.loader').fadeIn();
	} else {
		$('.loader').fadeOut();
	}
}
$(window).load(function(){
	centerLoader();
	$(window).resize(function(){
		centerLoader();
	});
});
// end loader
$('input[name="create_ts"]').on('click', function(evt){
	console.log('loader')
	loader(true)
});

// BestInPlace activate row calculate in table_specificationlight
function activateBestInPlace(data_attribute, type) {
    $('body').on('keyup', data_attribute, function() {
    	invoker = $(this);
    	console.log(type)
    	if (type == 'light_table') {
    		calculateLight(invoker)
    	} else if (type == 'main_table') {
    		calculate(invoker)
    	}
    });
}

$(document).ready(function(){
	$('.addpict').simpleCropper();
	
	$(document).on('click', 'a.invoker', function(){
		invoker = $(this);
	});
	jQuery(function() {
	  return $('.best_in_place').best_in_place();
	});

})