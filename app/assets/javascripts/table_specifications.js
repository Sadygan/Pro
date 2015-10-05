// alert('qqq')
jQuery(function() {
  return $('.best_in_place').best_in_place();
});

$(document).ready(function() {
	


	$(document).on('blur','#txt_fullname', function(){
	    var name = $(this).val();
	    //alert('Make an AJAX call and pass this parameter >> name=' + name);
		var calculate = {'table_specification': {'unit_v': 1}};
				
// 		$.ajax({
// 			url: './table_specifications/'+id,
// 			type: 'PUT',
// 			dataType: 'json',
// 			data: calculate,

// 			async: true,
// 			success: function (data) {

// 			}
// 		});

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
		// Include helper file
	    var imported = document.createElement('calculating_helper.js');
	    // imported.src = '/assets/javascripts';
	    document.head.appendChild(imported);

		$('#assets').on('click focus keyup', '[data-attribute="unit_price_factory"], [name="discount"] select, [data-attribute="increment_discount"], [data-attribute="unit_v"], [data-attribute="number_of"], [data-attribute="interest_percent"], [data-attribute="arhitec_percent"], [data-attribute="group"], [data-attribute="additional_delivery"], [data-attribute="width"], [data-attribute="height"], [data-attribute="depth"], [data-attribute="percent_v"], .delivery select, .unit_v' , function(){
			// Get id
			var id = parseInt($(this).attr('id').replace(/\D+/g,""));
	        var delivery_id = parseInt($('#delivery_'+id+' option:selected').val());
	       	var delivery_text = ($('#delivery_'+id+' option:selected').text())
	      	var v_ = parseFloat($('form > input').val());
			
	      	// Get data input table
			var upf = parseFloat($('#best_in_place_table_specification_'+id+'_unit_price_factory').text());
	      	var discount = parseInt($('#discount_'+id+' option:selected').text());
			var additional_discount = parseFloat($('#best_in_place_table_specification_'+id+'_increment_discount').text());
	        var unitV = parseFloat($('#best_in_place_table_specification_'+id+'_unit_v').text());
	        var number_of = parseFloat($('#best_in_place_table_specification_'+id+'_number_of').text());
	        var interest_percent = parseFloat($('#best_in_place_table_specification_'+id+'_interest_percent').text());
	        var arhitec_percent = parseFloat($('#best_in_place_table_specification_'+id+'_arhitec_percent').text());
	        var additional_delivery = parseFloat($('#best_in_place_table_specification_'+id+'_additional_delivery').text());

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

       		upf = isntNan(upf, v_)
	       	additional_discount = isntNan(additional_discount, v_)
	       	unitV = isntNan(unitV, v_)
	       	number_of = isntNan(number_of, v_)
	       	interest_percent = isntNan(interest_percent, v_)
	       	arhitec_percent = isntNan(arhitec_percent, v_)
	       	additional_delivery = isntNan(additional_delivery, v_)
			width = isntNan(width, v_)
			height = isntNan(height, v_)
			depth = isntNan(depth, v_)
			percent_v = isntNan(percent_v, v_)

			var unit_v_t = $('#unit_v_'+id)
			tableCheckSize(width, height, depth, percent_v, unit_v_t, id)

			
			

			// Correct unit_V and recortd table_specification.unit_v
			$(".uv").click( function(e){   
			    if($(this).find('input').length){
			         return ;   
			    }        
			    var input = $("<input type='text' size='5' />").val( $(this).text() );
			    $(this).empty().append(input);
			    input.focus();
			    $(this).find('input')
			    .focus(function(e){
			        if($(this).val()=='0.00' || $(this).val()=='0'){$(this).val('');}
			    }).keydown(function(event){
			         if ( event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 190  || event.keyCode == 13 || 
			              // Allow: Ctrl+A
			             (event.keyCode == 65 && event.ctrlKey === true) || 
			             // Allow: home, end, left, right
			             (event.keyCode >= 35 && event.keyCode <= 39)) {
			             // let it happen, don't do anything
			             return;
			        }
			        else {
			            // Ensure that it is a number and stop the keypress
			            if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105 )) {
			                event.preventDefault(); 
			            }   }
			    }).blur( function(e){
			              	if($(this).val()!=""){
								if (!isNaN(parseFloat($(this).val()))) {
									var val1=parseFloat($(this).val()).toFixed(2);
									$(this).val(val1);
									$(this).parent('.uv').text( 
										  $(this).val()
									);
									
									val1 = parseFloat(val1)
									console.log(val1)
									var v1 = {'table_specification': {'unit_v': val1}};

									$.ajax({
							    		url: 'table_specifications/'+id,
							    		type: 'PUT',
							    		dataType: 'json',
							    		data: v1,
							    		async: true,
										success: function (data) {

										}
									});
								  }
								}
								else{
										$(this).parent('.uv').text("0.00");
								}
			            });    
				});




			// -------------------
			
		});
	};
});


// $(document).ready(function() {
// 	// addSumm();
// 	// putSumm();
// 	var ts_id;
// 	var ids = 0;
//     $(document).on('click', '.brand', function () {


//         var html = $(this).text()
//         var input = $('<input type="text" class="brand" id="autocomplete" />');
//         var t_id = $(this).attr('id'); // это тебе надо при отправке на сервер - знать что меняешь

//         // var discount_values = parseInt($('#discount_brand_'+id).val());
//         // console.log(discount_values);
        
//         // ids = parseInt(t_id.replace(/\D+/g,""));
// 		console.log(ids);

//         input.val(html);
//         $(this).replaceWith(input);
//         $('#assets input').focus();

// 		$.getJSON('/factories/brand', function(data) {
// 		    var acctNums = [];
// 		    var name_brand = 0;
 			

//  		    for(a in data) {
// 		        acctNums.push(data[a].brand);
// 		    }

// 		    $("#autocomplete").autocomplete({
// 		        source: acctNums,
// 		        minLength: 1,
// 		        select: function( event, ui ) {
//                     var discount_brand = [];
// 		 			var brand = $( "input#autocomplete" ).val();
//                     $("#discount_brand_"+ids).html("asd");
//             		// console.log(data)
//             	}
// 		    });
// 		});
//     });

//     $(document).on('blur', 'input#autocomplete', function(){
//         $(this).replaceWith('<td class="brand"  id="brand_'+ids+'">'+this.value+'</td>')
//     })

//     // Render select option
//     function getFactoryOptions( arrFactories, discount ) {
//     // console.log(arrFactories);
//     var resultHtml = "";
    	
// 	    if (typeof arrFactories != "undefined") {
// 	       for (var i = 0; i < arrFactories.length; i++) {
// 		        if (arrFactories[i] == discount ) {
// 		        	resultHtml += "<option id='"+i+"' selected='selected' value='" + arrFactories[i] + "'>" + arrFactories[i] + "</option>";
// 		        } else {
// 		        	resultHtml += "<option id='"+i+"' value='" + arrFactories[i] + "'>" + arrFactories[i] + "</option>";
// 	       	    }
// 	        }
// 	     }
// 	    return resultHtml;
//     }
//     //Автокомлит брендов и добовление селект в строк колонки Discount
//     $.ajax({
//     	url:  "/factories/brand",
//     	type: "GET",
//     	dataType:'json',
//     	success: function(data){
// 	 		// Перебор колонки Brand  и добовление скидок
// 			var discount_brand_table = [];
// 			var brands = [];
// 			var discount_id = [];
			
// 			$('.brand').each(function(i,brand) {
// 				if ($(this).hasClass("stop")) {
// 					console.log("Остановлено на " + i + "-м пункте списка.");
// 					return false;
// 				} else {
// 					brands[i] = $(brand).text();
// 					discount_id[i] = brand.id;
// 					// console.log(brand)
// 				}
// 			});

// 			var discount_select = [];
// 			$('.factory_discount_hide').each(function(i, dis) {
// 				if ($(this).hasClass("stop")) {
// 					console.log("Остановлено на " + i + "-м пункте списка.");
// 					return false;
// 				} else {
// 					discount_select[i] = parseInt($(dis).text());
// 				}
// 			});

// 			// console.log(discount_select)
// 			var i = 0;
// 			var j = 0;
// 			var brand_table = [];
// 			var discount_arr_table = [];
// 			while (i < brands.length) {
// 				while (j < data.length ) {
// 					if (!brands[i].localeCompare(data[j].brand)) {
// 						brand_table[i] = data[j];
// 						discount_arr_table[i] = brand_table[i].discount.split(/[/]/);	

// 						$('#discount_'+discount_id[i]).html( getFactoryOptions (discount_arr_table[i], discount_select[i-1]));
// 					}
// 					j++;
// 				}
// 				j = 0;
// 				i++;
// 			}
//     	} 
//     });

// 	//Calculation table row
// 	$('.summ, .discount_select, .brand, [data-attribute="unit_price_factory"], [data-attribute="increment_discount"], [data-attribute="unit_v"], [data-attribute="factor"], [data-attribute="number_of"]').bind("click focus ajax:success", function(data){ 
// 		var id = parseInt($(this).attr('id').replace(/\D+/g,"")); // это тебе надо при отправке на сервер - знать что меняешь
// 		// console.log(id);
// 		var br = $('#brand_'+id).text();

// 		var upf = parseFloat($('#best_in_place_table_specification_'+id+'_unit_price_factory').text());
//       	var upf_f = parseFloat($('form > input').val());

//       	var discount_values = parseInt($('#discount_brand_'+id).val());

// 		var add_discount = parseFloat($('#best_in_place_table_specification_'+id+'_increment_discount').text());
//         var unitV = parseFloat($('#best_in_place_table_specification_'+id+'_unit_v').text());
//         var factor = parseFloat($('#best_in_place_table_specification_'+id+'_factor').text());
//         var number_of = parseFloat($('#best_in_place_table_specification_'+id+'_number_of').text());

//         if (isNaN(upf)) {
//         	upf = upf_f
//         }
      
// 		var upn = priceNetto(discount_values, upf, add_discount);

//         var sn = multiplication(upn, number_of);
//         var sv = multiplication(unitV, number_of);
//         var up = multiplication(upn, factor);
//         var summ = multiplication(up, number_of); 

//         upn = upn.toFixed(2)
//         sn = sn.toFixed(2)
//         sv = sv.toFixed(1)
//         up = up.toFixed(2)
//         summ = summ.toFixed(2)

// 		$('#unit_price_netto_'+id).text(upn);
// 		$('#summ_netto_'+id).text(sn); 
// 		$('#summ_v_'+id).text(sv); 
// 		$('#unit_price_'+id).text(up); 
// 		$('#summ_'+id).text(summ);

// 		$("#unit_price_netto_"+id).html($(data).find("#unit_price_netto_"+id).html())

// 		var calculate = {'table_specification': {'factory_discount': discount_values, 'unit_price_netto': upn, 'summ_netto': sn, 'summ_v': sv, 'unit_price': up, 'summ': summ}};
				
// 		$.ajax({
// 			url: './table_specifications/'+id,
// 			type: 'PUT',
// 			dataType: 'json',
// 			data: calculate,

// 			async: true,
// 			success: function (data) {

// 			}
// 		});

// 		addSumm();
// 		putSumm();

// 	});
// 	$('#print_sum').click(function() {
// 		var print = ($("#print_sum").prop("checked"));
// 		printSum(print);
// 	});
		
// 	function priceNetto(percent, upf, add_discount) {
// 	    if (add_discount == 0) {
// 	        return upf - (upf / 100 * percent);
// 	    }
// 	    else {
// 	        var price = upf - (upf / 100 * percent);
// 	        return price + (price / 100 * add_discount);
// 	    }
// 	}

//     function multiplication(value, numberOf) {
//         return value * numberOf;
//     }

//     function multiplicationSumm(value, numberOf) {
//         // console.log(value * numberOf + value);
//         return value * numberOf + value;
//     }

// 	function addSumm() {
// 		var summing = [];
// 		$('.all').each(function(i, dis) {
// 			if ($(this).hasClass("stop")) {
// 				console.log("Остановлено на " + i + "-м пункте списка.");
// 				return false;
// 			} else {
// 				summing[i] = parseFloat($(dis).text());
				
// 			}
// 		});		
			
// 		// $("summ").html("hello");
// 		var summa = 0.0;
// 		$.each(summing, function () {

// 		 summa = Number(summa) + Number(this);
// 		});
// 		summa = summa.toFixed(2)
// 		$('#specification_summ').html(summa)
// 		// console.log(summa)
// 		return summa;
// 	}

// 	function putSumm() {
// 		var specification_id = parseInt($('.specification_id').text());
// 		// console.log(addSumm())
// 		var summing = {'specification': {'summ': addSumm()}};
// 		$.ajax({
// 			url: '../'+specification_id,
// 			type: 'PUT',
// 			dataType: 'json',
// 			data: summing,

// 			async: true,
// 			success: function (data) {
// 				// console.log(data)
// 			}
// 		});
// 	}

// 	function printSum(print) {
// 		console.log(print)
// 		var specification_id = parseInt($('.specification_id').text());
// 		var p = {'specification': {'print_sum': print}};

// 		$.ajax({
// 			url: '../'+specification_id,
// 			type: 'PUT',
// 			dataType: 'json',
// 			data: p,

// 			async: true,
// 			success: function (data) {
// 				// console.log(data)
// 			}
// 		});
// 	}
// });
