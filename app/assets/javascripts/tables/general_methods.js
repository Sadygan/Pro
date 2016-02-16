function trueValue(input, text) {
	var trval;
	if (input === undefined) {
		trval = text;
	} else {
		trval = input;
	}
	return trval;	
}

/***функция пересчета***/
function calculate(td){
	var price_input = td.closest('tr').find('input.price').val();
	var price_text = td.closest('tr').find('[data-bip-attribute="unit_price_factory"] input').val() || td.closest('tr').find('[data-bip-attribute="unit_price_factory"]').text();
	var price = trueValue(price_input, price_text)
	
	var discount = td.closest('tr').find('span.discount-value').text() * price / 100;
	var additional_discount = td.closest('tr').find('input.table_specification_additional_discount').val();
	additional_discount = (price - discount) * additional_discount / 100;
	var price_with_discount = price - discount - additional_discount;
	
	var number_input = td.closest('tr').find('input.number').val();
	var number_text = td.closest('tr').find('[data-bip-attribute="number_of"]').text() || td.closest('tr').find('[data-bip-attribute="number_of"] input').val();
	var number = trueValue(number_input, number_text)

	/* Сумма фабрики */
	var factory_sum = Math.round(price_with_discount * number * 100) / 100;
	td.closest('tr').find('.factory-sum').text(factory_sum);
	
	/* Доставка */
	var ajax_delivery_cost = td.closest('tr').find('.delivery_data .cost').val()*1;
	var add_to_delivery = td.closest('tr').find('input.add_to_delivery').val()*1;
	
	var v_input = td.closest('tr').find('input.unit_v').val();
	var v_text = td.closest('tr').find('span.unv').text() || td.closest('tr').find('span.unit_v').text();
	
	var v;
	if (v_input === undefined) {
		v = v_text * number;
	} else {
		v = v_input * number;
	}
	td.closest('tr').find('.unv').text(v);
	var packing = td.closest('tr').find('input.packing').val()*1;
	var delivery = (ajax_delivery_cost + add_to_delivery) * v + packing;
	
	/* Сумма в ноль */
	var ajax_bank_service = td.closest('tr').find('.delivery_data .bank_service').val()*1;
	var ajax_bank_percent = td.closest('tr').find('.delivery_data .bank_percent').val()*1;
	ajax_bank_percent = (factory_sum + ajax_bank_service) * ajax_bank_percent / 100;
	var ajax_documents = td.closest('tr').find('.delivery_data .execution_document').val()*1;
	var ajax_check_factory = td.closest('tr').find('.delivery_data .check_factory').val()*1;
	var zero_sum = factory_sum + ajax_bank_service + ajax_bank_percent + ajax_documents + ajax_check_factory + delivery;
	//alert(zero_sum);
	
	/* Полная сумма */
	var interest_percent_input = td.closest('tr').find('input.interest').val();
	var interest_percent_text = td.closest('tr').find('[data-bip-attribute="interest_percent"] input').val() || td.closest('tr').find('[data-bip-attribute="interest_percent"]').text();
	var interest_percent = trueValue(interest_percent_input, interest_percent_text);
	var full_sum = Math.round(zero_sum * 100 / (100 - interest_percent)*100)/100;
	td.closest('tr').find('.full_sum').text(full_sum);
	
	/* Полная цена */
	var coefficient = full_sum/factory_sum;
	var full_price = Math.round(price_with_discount*coefficient*100)/100;
	td.closest('tr').find('.full_price').text(full_price);
	
	/* Интерес */
	var architector_percent_input = td.closest('tr').find('input.arh-interest').val();
	var architector_percent_text = td.closest('tr').find('[data-bip-attribute="arhitec_percent"] input').val() || td.closest('tr').find('[data-bip-attribute="arhitec_percent"]').text();
	var architector_percent = trueValue(architector_percent_input, architector_percent_text)

	var profit = full_sum - zero_sum;
	var interest = Math.round((profit - profit/100*architector_percent)*100)/100;
	td.closest('tr').find('.interest-e').text(interest);
	console.log(architector_percent)
	
	/* Интерес архитектора */
	var arch_interest = Math.round((profit - interest)*100)/100;
	var arh_order_percent = Math.round(100 - (full_sum - arch_interest) / full_sum * 100);
	td.closest('tr').find('.arh-interest-e').text(arch_interest);
	td.closest('tr').find('.arh-order-percent').text(arh_order_percent);
}

function calculateLight(td){
	var price_input = td.closest('tr').find('input.price').val();
	var price_text = td.closest('tr').find('[data-bip-attribute="unit_price_factory"] input').val() || td.closest('tr').find('[data-bip-attribute="unit_price_factory"]').text();
	var price = trueValue(price_input, price_text);

	var coefficient = td.closest('tr').find('.light_factor').text();
	console.log(coefficient)
	var number_input = td.closest('tr').find('input.number').val();
	var number_text = td.closest('tr').find('[data-bip-attribute="number_of"]').text() || td.closest('tr').find('[data-bip-attribute="number_of"] input').val();
	var number = trueValue(number_input, number_text)
	console.log(number)
	
	/* Сумма фабрики */
	var factory_sum = Math.round(price * coefficient * number * 100) / 100;
	td.closest('tr').find('.factory-sum').text(factory_sum);
	
	/* Полная цена */
	//var coefficient = full_sum/factory_sum;
	var interest_percent_input = td.closest('tr').find('input.interest').val();
	var interest_percent_text = td.closest('tr').find('[data-bip-attribute="interest_percent"] input').val() || td.closest('tr').find('[data-bip-attribute="interest_percent"]').text();
	var interest_percent = trueValue(interest_percent_input, interest_percent_text);
	var full_price = Math.round(price * coefficient  * 100 / (100 - interest_percent) * 100) / 100;
	td.closest('tr').find('.full_price').text(full_price);
	console.log(interest_percent)
	
	/* Полная сумма */
	var full_sum = Math.round(full_price * number *100)/100;
	td.closest('tr').find('.full_sum').text(full_sum);
	
	/* Интерес */
	var architector_percent_input = td.closest('tr').find('input.arh-interest').val();
	var architector_percent_text = td.closest('tr').find('[data-bip-attribute="arhitec_percent"] input').val() || td.closest('tr').find('[data-bip-attribute="arhitec_percent"]').text();
	var architector_percent = trueValue(architector_percent_input, architector_percent_text);
	var profit = full_sum - factory_sum;
	var interest = Math.round((profit - profit/100*architector_percent)*100)/100;
	td.closest('tr').find('.interest-e').text(interest);
	console.log(interest_percent)
	
	/* Интерес архитектора */
	var arch_interest = Math.round((profit - interest)*100)/100;
	var arh_order_percent = Math.round(100 - (full_sum - arch_interest) / full_sum * 100);
	td.closest('tr').find('.arh-interest-e').text(arch_interest);
	td.closest('tr').find('.arh-order-percent').text(arh_order_percent);
}

function modalSelect(modal, c_modal) {
	var selected = $('#'+modal+c_modal+' select :selected').val();
	var single = $('#'+modal+c_modal+' span').attr('value');
	var selected_discount = $('#'+modal+c_modal+' select :selected').text(); // Поменял переменные
	var single_discount = $('#'+modal+c_modal+' span').text(); // Добавил переменную
	var current_discount = 0;
	var current_discount_val = 0;
	var cdv = [0, 1]
	if (selected_discount == ""){ // Добавил условие для изменения скидки в ДОМ
		// discount percent
		cdv[0] = current_discount = single_discount;
		//value
		cdv[1] = current_discount_val = single;
	} else {
		// discount percent
		cdv[0] = selected_discount;
		//value
		cdv[1] = selected;
	}
	return cdv;
}

function ajaxCall(url, type, dataType, data) {
	$.ajax({
		url: url,
		type: type,
		dataType: dataType,
		data: data, 
		success: function (data) {

		}
	})
}
$(function() {
  return $(document).on('click', '.print_sum input', function(evt) {
    $.ajax('/tables/update_print_sum', {
      type: 'GET',
      dataType: 'script',
      data: {
        print_sum: $(this).prop('checked'),
        specification_id: $(this).val()
      },
      error: function(jqXHR, textStatus, errorThrown) {},
      success: function(data, textStatus, jqXHR) {
      	console.log($(this).val())
      }
    });
    return false;
  });
});