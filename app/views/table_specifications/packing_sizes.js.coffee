change_modal_a = $(invoker).closest('a')
if (change_modal_a).hasClass('shvg_percent')
	# Render the new form
	$('#modalv_table .modal-body').html '<%= j render("table_specifications/packing_size/form_table", as: @product) %>'
	# Show the dynamic dialog
	$('#modalv_table').modal 'show'
	# Set focus to the first element
	$('#modalv_table').on 'shown.bs.modal', ->
	  $('.first_input').focus()
	  return
else if (change_modal_a).hasClass('shvg')
	# Render the new form
	$('#modalv .modal-body').html '<%= j render("table_specifications/packing_size/form") %>'
	# Show the dynamic dialog
	$('#modalv').modal 'show'
	# Set focus to the first element
	$('#modalv').on 'shown.bs.modal', ->
#	  $('.first_input').focus()
	  return false
#else
	# Render the new form
#	$('#modalv .modal-body').html '<%= j render("table_specifications/packing_size/form") %>'
	# Show the dynamic dialog
#	$('#modalv').modal 'show'
	# Set focus to the first element
#	$('#modalv').on 'shown.bs.modal', ->
#	  $('.first_input').focus()
#	  return