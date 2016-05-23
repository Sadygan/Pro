// Add the dialog title
$('#dialog_line_group h3').html("<i class='glyphicon glyphicon-plus'></i><%= t('products.new_product') %>");
 
// Render the new form
$('.modal-body').html('<%= j render("form") %>');
 
// Show the dynamic dialog
$('#dialog_line_group').modal("show");
 
// Set focus to the first element
$('#dialog').on('shown.bs.modal', function () {
	  $('.first_input').focus()
  })
