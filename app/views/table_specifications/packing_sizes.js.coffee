change_modal = $(invoker).closest('td')
console.log(change_modal)
if (change_modal).hasClass('v_table')
	# Render the new form
	$('#modalv_table .modal-body').html '<%= j render("table_specifications/packing_size/form_table", as: @product) %>'
	# Show the dynamic dialog
	$('#modalv_table').modal 'show'
	# Set focus to the first element
	$('#modalv_table').on 'shown.bs.modal', ->
	  $('.first_input').focus()
	  return
else
		# Render the new form
	$('#modalv .modal-body').html '<%= j render("table_specifications/packing_size/form") %>'
	# Show the dynamic dialog
	$('#modalv').modal 'show'
	# Set focus to the first element
	$('#modalv').on 'shown.bs.modal', ->
	  $('.first_input').focus()
	  return