jQuery(function() {
  return $('.best_in_place').best_in_place();
});
function calculateLight(td){
	var price = td.closest('tr').find('input.price').val();
	var coefficient = td.closest('tr').find('#number_factor span').text();
	var number = td.closest('tr').find('input.number').val();
	
	/* Сумма фабрики */
	var factory_sum = Math.round(price * coefficient * number * 100) / 100;
	td.closest('tr').find('.factory-sum').text(factory_sum);
	
	/* Полная цена */
	//var coefficient = full_sum/factory_sum;
	var interest_percent = td.closest('tr').find('input.interest').val();
	var full_price = Math.round(price * coefficient  * 100 / (100 - interest_percent) * 100) / 100;
	td.closest('tr').find('.full_price').text(full_price);
	
	/* Полная сумма */
	var full_sum = Math.round(full_price * number *100)/100;
	td.closest('tr').find('.full_sum').text(full_sum);
	
	/* Интерес */
	var architector_percent = td.closest('tr').find('input.arh-interest').val();
	var profit = full_sum - factory_sum;
	var interest = Math.round((profit - profit/100*architector_percent)*100)/100;
	td.closest('tr').find('.interest-e').text(interest);
	
	/* Интерес архитектора */
	var arch_interest = Math.round((profit - interest)*100)/100;
	var arh_order_percent = Math.round(100 - (full_sum - arch_interest) / full_sum * 100);
	td.closest('tr').find('.arh-interest-e').text(arch_interest);
	td.closest('tr').find('.arh-order-percent').text(arh_order_percent);
}

$(document).ready(function() {
	console.log('qwe')
	calculate($('input:first'));
	$('input').on('change keyup', function(){
		calculate($(this));
	});
});