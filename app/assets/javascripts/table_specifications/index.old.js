jQuery(function() {
  return $('.best_in_place').best_in_place();
});



$(document).ready(function() {
	var client = new Dropbox.Client({
	  key:    "oqe1u2h3676wzpc", // App key
	  secret: "6d38819v60m67c1", // App secret
	  token:  "yza6vaucz0yy8eeb", // Generated access token
	  user:   "489572075",
	  sandbox: false
	});

    console.log(client);
    client.isAuthenticated();
    
    // $('.specification_id').html()

	
	$('#print_sum').click(function() {
		var print = ($("#print_sum").prop("checked"));
		var specification_id = parseInt($('.specification_id').text());
		var url = '../'+specification_id;
		var p = {'specification': {'print_sum': print}};
		printSum(p, specification_id, url);
	});

	$(document).on('blur','#txt_fullname', function(){
	    var name = $(this).val();
	    //alert('Make an AJAX call and pass this parameter >> name=' + name);
		var calculate = {'table_specification': {'unit_v': 1}};
				
	    $('.uv').text(name);
	});


    $.ajax({
    	url: '/deliveries/',
		type: 'GET',
		dataType: 'json',
		success: function(data) {
			tableCalculation(data);

		}
	});

	function tableCalculation(data) {
		// console.log(data)
		// Include helper file
	    var imported = document.createElement('calculating_helper.js');
	    // imported.src = '/assets/javascripts';
	    document.head.appendChild(imported);

		$('[name="photo_select"]').click(function(){
	      	var id = $(this).attr('id').replace(/\D+/g,"");
	      	var img_id = parseInt($("#photo_"+id+" select option:selected").attr("value"));
	      	var img_path = $("#photo_"+id+" select option:selected").attr("path");
	      	console.log(img_path)
	      	var article = $("#photo_"+id+" select option:selected").attr("article");
	      	var photo_src = '';
	      	var img_file_name = $("#photo_"+id+" option:selected").attr("name")
	      	photo_src += '<img src="'+img_path+'">'
	      	$('#current_photo_'+id).html(photo_src);
		
			// Set current image ID
			console.log(img_id)
			var setImage = {'table_specification': {'photo_id': img_id}}

			$.ajax({
				url: './table_specifications/'+id,
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
	      	var img_path = $("#size_image_"+id+" select option:selected").attr("path");
	      	var article = $("#size_image_"+id+" select option:selected").attr("article");
	      	var photo_src = '';
	      	var img_file_name = $("#size_image_"+id+" option:selected").attr("name")
	      	photo_src += '<img src="'+img_path+'">'
	      	$('#current_size_image_'+id).html(photo_src);
		
			// Set current image ID
			var setImage = {'table_specification': {'size_image_id': img_id}}
			$.ajax({
				url: './table_specifications/'+id,
				type: 'PUT',
				dataType: 'JSON',
				data: setImage
			});
		});

		$('[name="discount_select"]').click(function() {
			var id = parseInt($(this).attr('id').replace(/\D+/g,""));
			var discount_id = parseInt($("#discount_"+id+" select option:selected").attr("discount_id"));
			console.log(discount_id)

			// Set current discount
			var setImage = {'table_specification': {'discount_id': discount_id}}
			$.ajax({
				url: './table_specifications/'+id,
				type: 'PUT',
				dataType: 'JSON',
				data: setImage
			});
		});

		$('[name="delivery_select"]').click(function() {
			var id = parseInt($(this).attr('id').replace(/\D+/g,""));
			var delivery_id = parseInt($('#delivery_'+id+' option:selected').val());
			console.log(delivery_id);

			// Set current delivery
			var setImage = {'table_specification': {'delivery_id': delivery_id}}
			$.ajax({
				url: './table_specifications/'+id,
				type: 'PUT',
				dataType: 'JSON',
				data: setImage
			});
		});

	 	$('#assets').on('change click focus keyup', '[name="delivery_select"],  #temp, [name="discount_select"], [data-bip-attribute="unit_price_factory"], [data-bip-attribute="increment_discount"], [data-bip-attribute="unit_v"], [data-bip-attribute="number_of"], [data-bip-attribute="interest_percent"], [data-bip-attribute="arhitec_percent"], [data-bip-attribute="group"], [data-bip-attribute="additional_delivery"], [data-bip-attribute="width"], [data-bip-attribute="height"], [data-bip-attribute="depth"], [data-bip-attribute="percent_v"], .delivery select, .unit_v', function(){
	 	// $('[name="group_v"], [name="delivery_select"], [name="discount_select"], [data-bip-attribute="unit_price_factory"], [data-bip-attribute="increment_discount"], [data-bip-attribute="unit_v"], [data-bip-attribute="number_of"], [data-bip-attribute="interest_percent"], [data-bip-attribute="arhitec_percent"], [data-bip-attribute="group"], [data-bip-attribute="additional_delivery"], [data-bip-attribute="width"], [data-bip-attribute="height"], [data-bip-attribute="depth"], [data-bip-attribute="percent_v"], .delivery select, .unit_v').bind('change click focus keyup', function(){
			
			// Get id
			var specification_id = parseInt($('.specification_id').text());
			var project_id = parseInt($('.project_id').text());
			var id_ = parseInt($(this).attr('id').replace(/\D+/g,""));
	        var group_id = parseInt($(this).attr('data-html-attrs'));
			if (!isNaN(id_)) {
				id = clone(id_)
			} else {
				number_of = number_of_
			}

			// console.log(group_id)

	        var delivery_id = parseInt($('#delivery_'+id+' option:selected').val());
	       	var delivery_text = ($('#delivery_'+id+' option:selected').text() || $('#group_delivery_'+group_id+' div select option:selected').text());
	      	var v_ = parseFloat($('form > input').val());
			var additional_discount = parseFloat($('#additional_discount_'+id).text()) || 0;

	      	// Get data input table
			var upf = parseFloat($('#best_in_place_table_specification_'+id+'_unit_price_factory').text());
	      	var discount = parseInt($('#discount_'+id+' option:selected').text());
			var increment_discount = parseFloat($('#best_in_place_table_specification_'+id+'_increment_discount').text());
	        var unitV = parseFloat(
	        	$('#best_in_place_table_specification_'+id+'_unit_v').text() 
	        	|| $('#temp_'+id).val()
	        	|| $("#unit_v_"+id).text());
	        	unitV.toFixed(2);

			// console.log(unitV)
	        var number_of_ = parseFloat($('#best_in_place_table_specification_'+id+'_number_of').text());
			if (!isNaN(number_of_)) {
				number_of = clone(number_of_)
			} else {
				number_of = number_of_
			}

	        var interest_percent = parseFloat(
	        	$('#best_in_place_table_specification_'+id+'_interest_percent').text() || 
	        	$('#best_in_place_table_specification_'+id+'_interest_percent input').val() ||
	        	$('#interest_percent_group [data-html-attrs="'+group_id+'"]').text());
	        var arhitec_percent = parseFloat(
	        	$('#best_in_place_table_specification_'+id+'_arhitec_percent').text() || 
	        	$('#best_in_place_table_specification_'+id+'_arhitec_percent input').val() ||
	        	$('#arhitec_percent_group [data-html-attrs="'+group_id+'"]').text());
	        var additional_delivery = parseFloat(
	        	$('#best_in_place_table_specification_'+id+'_additional_delivery').text() || 
	        	$('#best_in_place_table_specification_'+id+'_additional_delivery input').val() ||
	        	$('#additional_delivery_group [data-html-attrs="'+group_id+'"]').text());
			
			group_upf = parseFloat(groupArrSum(".unit_price_factory", group_id, upf))
	        group_upf_netto = parseFloat(groupArrSum(".unit_price_netto", group_id, unit_price_factory))
	        group_sum_netto = parseFloat(groupArrSum(".summ_netto", group_id, 0).toFixed(2))
      	    group_sum_v = parseFloat(groupArrSum(".summ_v", group_id, 0).toFixed(2))
      	    console.log(group_sum_v)
	       	// Get delivey
			var delivery = getDelivery(data, delivery_text)
	       	var cost = delivery.cost
	       	var execution_document = delivery.execution_document 
	       	var direction = delivery.direction
	       	var check_factory = delivery.check_factory
	       	var bank_service = delivery.bank_service
	       	var bank_percent = delivery.bank_percent
	       	
	       	upf = isntNan(upf, v_)
	       	additional_discount = isntNan(additional_discount, v_)
	       	unitV = isntNan(unitV, v_)
	       	number_of = isntNan(number_of, v_)
	       	interest_percent = isntNan(interest_percent, v_)
	       	arhitec_percent = isntNan(arhitec_percent, v_)
	       	additional_delivery = isntNan(additional_delivery, v_)

	       	// Get size
	       	var width = parseFloat($('#best_in_place_table_specification_'+id+'_width').text());
	       	var height = parseFloat($('#best_in_place_table_specification_'+id+'_height').text());
	       	var depth = parseFloat($('#best_in_place_table_specification_'+id+'_depth').text());
	       	var percent_v = parseFloat($('#best_in_place_table_specification_'+id+'_percent_v').text());

	       	// console.log(number_of * 2)

       		upf = isntNan(upf, v_);

	       	unitV = isntNan(unitV, v_);
	       	number_of = isntNan(number_of, v_);
	       	interest_percent = isntNan(interest_percent, v_);
	       	arhitec_percent = isntNan(arhitec_percent, v_);
	       	additional_delivery = isntNan(additional_delivery, v_);
			width = isntNan(width, v_);
			height = isntNan(height, v_);
			depth = isntNan(depth, v_);
			percent_v = isntNan(percent_v, v_);

			var unit_v_t = $('#best_in_place_table_specification_'+id+'_unit_v');
			tableCheckSize(width, height, depth, percent_v, unit_v_t, id, group_id, project_id, specification_id, unitV);

			var unit_price_factory = unitPriceNetto(discount, upf, additional_discount, increment_discount)
			var summa_netto = multiplication(unit_price_factory, number_of);
			var v_sum = multiplication(unitV, number_of);
			var price_at_nil = calculatePercentBankDelivery(summa_netto, cost, execution_document, check_factory,  bank_service, bank_percent, v_sum, additional_delivery);
	        price_at_nil = NanOrNoNan(price_at_nil);
			var with_interest = ourInterest(price_at_nil, interest_percent);
			var interest = minus(with_interest, price_at_nil);
			var architector = calculatePercentMinus(interest, arhitec_percent);
            var architector_percent = architectorPercent(with_interest, architector);
			var factor = devision(with_interest, summa_netto);
			var summa = multiplication(summa_netto, factor);
			var unit_price = multiplication(unit_price_factory, factor)
			// Draw value in cells
			$('#unit_price_netto_'+id).html(unit_price_factory.toFixed(2))
			$('#summ_netto_'+id).html(summa_netto.toFixed(2))
			$('#summ_v_'+id).html(v_sum.toFixed(2))
			$('#unit_price_'+id).html(unit_price.toFixed(2));
			$('#at_nil_'+id).html(price_at_nil);
			$('#with_interest_'+id).html(with_interest);
			$('#interest_'+id).html(interest.toFixed(2));
			$('#architector_'+id).html(architector.toFixed(2));
	        $('#architector_percent_from_order_'+id).html(architector_percent.toFixed(2));
	        $('#summ_'+id).html(summa.toFixed(2));
	        $('#factor_'+id).html(factor.toFixed(2));


	        group_price_from_nil = calculatePercentBankDelivery(group_sum_netto, cost, execution_document, check_factory,  bank_service, bank_percent, group_sum_v, additional_delivery);
	        group_with_interest = ourInterest(group_price_from_nil, interest_percent);
      	   	
      	   	group_percent_of_number = percent_of_number(summa_netto, group_sum_netto);
      	   	group_sum_price_with_interest = group_sum_price_with_inerest(group_percent_of_number, group_with_interest)
      	   	group_unit_price_with_interest = group_unit_price_with_inerest(group_sum_price_with_interest, number_of)

      	   	console.log(group_unit_price_with_interest)

	        group_number_of = parseFloat(groupArrSum(".number_of", group_id, number_of).toFixed(2))
	        group_interest = minus(group_with_interest, group_price_from_nil);
	        group_architector = calculatePercentMinus(group_interest, arhitec_percent);
	        // group_architector_percent = architectorPercent(group_with_interest, group_architector);
	        group_factor = devision(group_with_interest, group_price_from_nil);
	        // group_summa = multiplication(group_factor, group_sum_netto);
	        // console.log(group_sum_netto)
	        // console.log(group_with_interest)
      	    // gr_percent_of_number = percent_of_number(summa_netto, group_sum_netto)
      	    
      	    // console.log(group_price_from_nil)
      	    // console.log(gr_percent_of_number)
      	    // console.log(group_with_interest)
      	    // console.log(group_with_interest/100*gr_percent_of_number)

	        


	        // $('#group_sum_factory_'+group_id).html(group_upf.toFixed(2));
	        // $('#group_unit_netto_'+group_id).html(group_upf_netto.toFixed(2));
	        // $('#group_sum_netto_'+group_id).html(group_sum_netto.toFixed(2));
	        // $('#group_sum_v_'+group_id).html(group_sum_v.toFixed(2));
	        // $('#group_factor_'+group_id).html(group_factor.toFixed(2));
	        // $('#group_number_of_'+group_id).html(group_number_of.toFixed(2));
	        $('#group_from_nil_sum_'+group_id).html(group_price_from_nil);
	        $('#group_with_interest_'+group_id).html(group_with_interest);
	        $('#group_sum_price_with_interest_'+id).html(group_sum_price_with_interest);
	        $('#group_unit_price_with_interest_'+id).html(group_unit_price_with_interest);
	        $('#group_interest_'+group_id).html(group_interest.toFixed(2));
	        $('#group_architector_'+group_id).html(group_architector.toFixed(2));
	        // $('#group_architector_interest_from_order_'+group_id).html(group_architector_percent.toFixed(2));
	        $('#group_factor_'+group_id).html(group_factor.toFixed(2));
	        // $('#group_summa_'+group_id).html(group_summa.toFixed(2));

	        
	        // SUMM SPECIFICATION
	        sum_table = parseFloat(groupArrSum(".summa", group_id=0, 0));
        	vals = [];
        	$('.group [data-html-attrs]').each(function(){
        		vals.push(parseInt(this.parentElement.firstChild.attributes[6].nodeValue));
        	});
        	vals = vals.uniq();

        	var group_sum_ = 0;
        	for (i = 0; i < vals.length; i++) {
        		group_sum_ +=+ parseFloat(groupArrSum(".sum_group", vals[i], 0)).toFixed(2)
       			// console.log(group_sum_)
        	}
        	var sum_specification = sum_table + group_sum_;
	        $('#sum_specification').html(sum_specification.toFixed(2))

	     
		});
	};

});


