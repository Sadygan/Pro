# Render the new form
$('.modal-photo').html '<%= j render("tables/general_methods/photo/form") %>'
# Show the dynamic dialog
$('#modalpict').modal 'show'
# Set focus to the first element
$('#modalpict').on 'shown.bs.modal', ->
  $('.first_input').focus()
  return
