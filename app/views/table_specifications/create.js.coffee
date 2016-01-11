loader(true)
$('.table-button').show()
$('.new_table_specification').hide()
$(document).on "ajax:success", "form", (xhr, data, response) ->
	location.reload(false)
	if data.error
		for message of data
			$('#errors ul').append '<li>' + data.error[message] + '</li>'