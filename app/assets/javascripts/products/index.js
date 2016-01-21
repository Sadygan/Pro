$(document).ready(function() {
	console.log('product-ready')
	$('#modalIns .col-xs-3 input').on('change keyup',function() {
		if($('#product_unit_v').val() > 0 ){
			$('#product_width').prop('disabled', true);
			$('#product_height').prop('disabled', true);
			$('#product_depth').prop('disabled', true);
		} else {
			$('#product_width').prop('disabled', false);
			$('#product_height').prop('disabled', false);
			$('#product_depth').prop('disabled', false);
		}
		if(($('#product_width').val() > 0) || ($('#product_height').val() > 0) || ($('#product_depth').val() > 0)){
			$('#product_unit_v').prop('disabled', true);
		} else {
			$('#product_unit_v').prop('disabled', false);
		}
	});
});