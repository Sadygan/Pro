change_modal = $(invoker).closest('td')
if (change_modal).hasClass('v_table')
	console.log('ok')
	# Render the new form
	$('#modaldelivery_table .modal-body').html '<%= j render("table_specifications/delivery/form") %>'
	# Show the dynamic dialog
	$('#modaldelivery_table').modal 'show'
	# Set focus to the first element
	$('#modaldelivery_table').on 'shown.bs.modal', ->
	  $('.first_input').focus()
	  return	
else
	# Render the new form
	$('#modaldelivery .modal-body').html '<%= j render("table_specifications/delivery/form") %>'
	# Show the dynamic dialog
	$('#modaldelivery').modal 'show'
	# Set focus to the first element
	$('#modaldelivery').on 'shown.bs.modal', ->
	  $('.first_input').focus()
	  return
	delivery_id = 0
	additional = 0
	packing = 0 
	delivery_id = $('#table_specification_delivery_id').val()
	$('#post_deliveries_id').val(delivery_id)
	additional = $('#table_specification_additional_delivery').val()
	$('.addToDelivery').val(additional)
	packing = $('#table_specification_additional_packaging').val()
	$('.packingPrice').val(packing)
