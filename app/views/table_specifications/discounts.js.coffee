change_modal = $(invoker).closest('td')
console.log(change_modal)
if $(change_modal).hasClass('factory')
	# Render the new form
	$('#modalfactory_table .modal-body').html '<%= j render("table_specifications/discount/form") %>'
	# Show the dynamic dialog
	$('#modalfactory_table').modal 'show'
	# Set focus to the first element
	$('#modalfactory_table').on 'shown.bs.modal', ->
	  $('.first_input').focus()
	  return
else
	# Render the new form
	$('#modalfactory .modal-body').html '<%= j render("table_specifications/discount/form") %>'
	# Show the dynamic dialog
	$('#modalfactory').modal 'show'
	# Set focus to the first element
	$('#modalfactory').on 'shown.bs.modal', ->
	  $('.first_input').focus()
	  return
	incr_val = 0
	incr_val = $('#table_specification_increment_discount').val()
	$('#increment_discount_modal').val(incr_val)

