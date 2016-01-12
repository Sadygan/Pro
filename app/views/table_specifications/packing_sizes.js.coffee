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
	$('#modalv input').on 'change', ->
	  if $('#w').val()*1 != 0 && $('#h').val()*1 != 0 && $('#d').val()*1 != 0
	    $('#modalv .btn-primary').prop 'disabled', false
	  else
	    $('#modalv .btn-primary').prop 'disabled', true
	  return
#else
	# Render the new form
#	$('#modalv .modal-body').html '<%= j render("table_specifications/packing_size/form") %>'
	# Show the dynamic dialog
#	$('#modalv').modal 'show'
	# Set focus to the first element
#	$('#modalv').on 'shown.bs.modal', ->
#	  $('.first_input').focus()
#	  return