// alert('qqq')
jQuery(function() {
  return $('.best_in_place').best_in_place();
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
