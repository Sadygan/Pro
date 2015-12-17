# Render the new form
$('#modalfactory .modal-body').html '<%= j render("table_specifications/discount/form") %>'
# Show the dynamic dialog
$('#modalfactory').modal 'show'
# Set focus to the first element
$('#modalfactory').on 'shown.bs.modal', ->
  $('.first_input').focus()
  return