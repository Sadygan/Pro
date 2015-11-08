$(document).ready(function() { 
	var isDateInputSupported = function(){
	var elem = document.createElement('input');
	elem.setAttribute('type','date');
	elem.value = 'foo';
		return (elem.type == 'date' && elem.value != 'foo');
	}

	if (!isDateInputSupported())  // or.. !Modernizr.inputtypes.date
	  $('input[type="date"]').datepicker();

	$(".datapic").on('click keyup focus', '[data-attribute="date_delivery_client"]', function () {
		$('[data-attribute="date_delivery_client"]').datepicker({

		    onSelect: function(date, instance) {
		    	// console.log(this.name)
		        id = parseInt(this.name)
		        var p = {'project': {'date_delivery_client': date}}; 
		        $.ajax
		        ({
	            	type: "PUT",
	            	url: "projects/"+id,
	            	data: p,
	            	success: function(result)
	            	{
	                  //do something
	            	}
	        	});  
		    	}
			});
	})
});