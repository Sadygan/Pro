$(document).ready(function(){
	$('table').on('show.bs.collapse', '.collapse', function (e) {
		var actives = $('table').find('.in, .collapsing');
		actives.each( function (index, element) {
			$(element).collapse('hide');
		});
	});
	/*$('body').on('click', '.accordion-toggle', function(){
		$(this).toggleClass('active');
	});*/
	console.log('ok')
}); 