
#p = '<%= @product.id %>'
#photo_obj = $('.photo img')
#photo_obj.map (value, i) -> 
#	$.ajax 'products/product/create_img',
#	  type: 'POST'
#	  dataType: 'script'
#	  data: {
#	  	product_last_id: '<%= @product.id %>'
#	    image_base64: i.src
#	  }
#	  error: (jqXHR, textStatus, errorThrown) ->
#	    console.log("AJAX Error: #{textStatus}")
#	  success: (data, textStatus, jqXHR) ->

#size_images = $('#size_images img')
#size_images.map (value, i) -> 
#	$.ajax 'products/product/create_img',
#	  type: 'POST'
#	  dataType: 'script'
#	  data: {
#	    product_last_id: '<%= @product.id %>'
#	  	image_base64: i.src
#	  }
#	  error: (jqXHR, textStatus, errorThrown) ->
#	    console.log("AJAX Error: #{textStatus}")
#	  success: (data, textStatus, jqXHR) ->
#$(document).on "ajax:success", "form", (xhr, data, response) ->
#	location.reload(true)
#	if data.error
#		for message of data
#			$('#errors ul').append '<li>' + data.error[message] + '</li>'

#$('#dialog').modal('toggle');
#$('#products').append('<%= j render (@product) %>')