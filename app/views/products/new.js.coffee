# Add the dialog title
$('#dialog h3').html '<i class="glyphicon glyphicon-plus"></i><%= t("products.new_product") %>'
# Render the new form
$('.modal-body').html '<%= j render("form") %>'
# Show the dynamic dialog
$('#dialog').modal 'show'
# Set focus to the first element
$('#dialog').on 'shown.bs.modal', ->
  $('.first_input').focus()
  return

$('.chosen-select').chosen
  allow_single_deselect: false
  no_results_text: 'Add to Data Base'
  width: '100%'

$ ->
  $(document).on 'change', '#factories_select', (evt) ->
    $.ajax 'products/product/update_brand_models',
      type: 'GET'
      dataType: 'script'
      data: {
        factory_id: $("#factories_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log('okxxx')
        #$('input[name=commit]').prop('disabled', true);
$ ->
  $(document).on 'click', '#photos a', (evt) ->
    $.ajax 'table_specifications/table_specification/photos',
      type: 'GET'
      dataType: 'script'
      data: {
        product_id: $("#articles_select option:selected").attr("id")
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        product_id: $("#articles_select option:selected").attr("id")
        console.log("Dynamic country select OK!3333")
    return false

$(document).ready ->
  $('.addpict').simpleCropper()
  $('#modalIns .col-xs-3 input').on 'change keyup', ->
  if $('#product_unit_v').val() > 0
    $('#product_width').prop 'disabled', true
    $('#product_height').prop 'disabled', true
    $('#product_depth').prop 'disabled', true
  else
    $('#product_width').prop 'disabled', false
    $('#product_height').prop 'disabled', false
    $('#product_depth').prop 'disabled', false
  if $('#product_width').val() > 0 or $('#product_height').val() > 0 or $('#product_depth').val() > 0
    $('#product_unit_v').prop 'disabled', true
  else
    $('#product_unit_v').prop 'disabled', false
  return

