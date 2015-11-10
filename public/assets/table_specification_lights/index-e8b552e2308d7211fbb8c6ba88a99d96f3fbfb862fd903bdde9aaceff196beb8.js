jQuery(function() {
  return $('.best_in_place').best_in_place();
});

$(document).ready(function(){ 
	// Include helper file
	var imported = document.createElement('calculating_helper.js');
	// imported.src = '/assets/javascripts';
	document.head.appendChild(imported);

	$('[name="photo_select"]').click(function(){
      	var id = $(this).attr('id').replace(/\D+/g,"");
      	var img_id = parseInt($("#photo_"+id+" select option:selected").attr("value"));
      	var article = $("#photo_"+id+" select option:selected").attr("article");
      	var photo_src = '';
      	var img_file_name = $("#photo_"+id+" option:selected").attr("name")
      	photo_src += '<img src="/photos/product/'+article+'/Photo/'+img_file_name+'">'
      	$('#current_photo_'+id).html(photo_src);
	
		// Set current image ID
		console.log(img_id)
		var setImage = {'table_specification_light': {'photo_id': img_id}}

		$.ajax({
			url: './table_specification_lights/'+id,
			type: 'PUT',
			dataType: 'JSON',
			data: setImage, 
			success: function (data) {

			}
		})
	});

	$('[name="size_image_select"]').click(function(){
      	var id = parseInt($(this).attr('id').replace(/\D+/g,""));
      	var img_id = parseInt($("#size_image_"+id+" select option:selected").attr("value"));
      	var article = $("#size_image_"+id+" select option:selected").attr("article");
      	var photo_src = '';
      	var img_file_name = $("#size_image_"+id+" option:selected").attr("name")
      	photo_src += '<img src="/photos/product/'+article+'/SizeImage/'+img_file_name+'">'
      	$('#current_size_image_'+id).html(photo_src);
	
		// Set current image ID
		var setImage = {'table_specification_light': {'size_image_id': img_id}}
		$.ajax({
			url: './table_specification_lights/'+id,
			type: 'PUT',
			dataType: 'JSON',
			data: setImage
		});
	});

	$('#print_sum').click(function() {
		var print = ($("#print_sum").prop("checked"));
		var specification_id = parseInt($('.specification_id').text());
		var url = '../'+specification_id;
		var p = {'specification': {'print_sum': print}};
		printSum(p, specification_id, url);
	});

	$("#assets").on('click focus keyup','[data-attribute="unit_price_factory"], [data-attribute="number_of"], [data-attribute="interest_percent"], [data-attribute="arhitec_percent"]', function(){
		var id = parseInt($(this).attr('id').replace(/\D+/g,""));
		
		var unit_price_factory, number_of, interest_percent, arhitec_percent,
			summ_netto, unit_price_factor, price_from_nil, with_interest, interest, 
			architector, architector_percent, sum;

		var id_place = '#best_in_place_table_specification_light_'+id

		unit_price_factory = parseFloat($(id_place+'_unit_price_factory').text() || $(id_place+'_unit_price_factory input').val());
		factor = parseFloat($('#factor_light_'+id).text());
		number_of = parseFloat($(id_place+'_number_of').text() || $(id_place+'_number_of input').val());
		interest_percent = parseFloat($(id_place+'_interest_percent').text() || $(id_place+'_interest_percent input').val());
		arhitec_percent = parseFloat($(id_place+'_arhitec_percent').text() || $(id_place+'_arhitec_percent input').val());

		summ_netto = multiplication(unit_price_factory, number_of);
		unit_price_factor = multiplication(unit_price_factory, factor);
		price_from_nil = multiplication(unit_price_factor, number_of);
		with_interest = ourInterest(price_from_nil, interest_percent);
		unit_with_interest = with_interest / number_of;
		interest = minus(with_interest, price_from_nil);
		architector_interest = calculatePercentMinus(interest, arhitec_percent);
		architector_percent_from_order = architectorPercent(with_interest, architector_interest);

		$('#summ_netto_'+id).html(summ_netto.toFixed(2));
		$('#unit_price_factor_'+id).html(unit_price_factor.toFixed(2));
		$('#price_from_nil_'+id).html(price_from_nil.toFixed(2));
		$('#unit_with_interest_'+id).html(unit_with_interest.toFixed(2));
		$('#with_interest_'+id).html(with_interest);
		$('#interest_'+id).html(interest.toFixed(2));
		$('#architector_interest_'+id).html(architector_interest.toFixed(2));
		$('#architector_percent_from_order_'+id).html(architector_percent_from_order.toFixed(2));

		sum = 0;
		$('.with_interest').each(function(){
			sum +=+ parseFloat(this.textContent)
		});

		$('#light_sum').html(sum.toFixed(2));
	});
});
