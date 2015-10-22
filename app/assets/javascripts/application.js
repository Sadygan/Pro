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
//= require jquery-ui
//= require autocomplete-rails
//= require bootstrap-sprockets
//= require bootstrap-filestyle
//= require best_in_place
//= require turbolinks
//= require bootstrap
//= require nested_form_fields
//= require_tree .

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

