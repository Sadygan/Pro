var imported = document.createElement('calculating_helper.js');
// imported.src = '/assets/javascripts';
document.head.appendChild(imported);
$(document).ready(function() {
	$(':checkbox').click(function() {
		
		var print = ($(this).prop("checked"));
		var specification_id = parseInt($(this).attr('id').replace(/\D+/g,""));
		var project_id = parseInt($('[name="project_id"]').attr('id').replace(/\D+/g,""));
		var chk_val = $(this).val();
		
		var url, p;
		// console.log(chk_val)
		
		if (chk_val == "specification") {
			url = project_id+'/specifications/'+specification_id
			p = {'specification': {'print_sum': print}};

		} else if (chk_val == "project") {
			url = '/projects/'+specification_id
			p = {'project': {'print_sum': print}};

		}

		printSum(p, specification_id, url);
	});
});
