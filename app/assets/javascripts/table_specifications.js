var invoker;

$(document).ready(function() {
	$(document).on('click', 'a.invoker', function(){
		invoker = $(this);
		console.log(invoker);
	});
	$('body').on('click','#modalpict a',function(){
		$('#modalpict').modal('hide');
		var imgsrc=$(this).find('img').attr('src');
		$(invoker).find('img').attr('src',imgsrc);
		console.log(invoker);
		return false;
	});
	$('body').on('click','#modalsize a',function(){
		$('#modalsize').modal('hide');
		var imgsrc=$(this).find('img').attr('src');
		$(invoker).find('img').attr('src',imgsrc);
		return false;
	});
	$('#modalv button').click(function(){
		$('#modalv').modal('hide');
	});
	$('#modaldelivery button').click(function(){
		$('#modaldelivery').modal('hide');
	});
	$('#modalfactory select option').click(function(){
		var selected = $(this).val();
		$('#modalfactory').modal('hide');
		$(invoker).find('span').text(selected);
	});
	
	$('.addpict').simpleCropper()
});