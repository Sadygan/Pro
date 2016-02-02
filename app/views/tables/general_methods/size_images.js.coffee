# Render the new form
$('.modal-size-image').html '<%= j render("table_specifications/size_image/form") %>'
# Show the dynamic dialog
$('#modalsize').modal 'show'
# Set focus to the first element
$('#modalsize').on 'shown.bs.modal', ->
  $('.first_input').focus()
  return