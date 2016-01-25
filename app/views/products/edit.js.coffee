# Add the dialog title
$('#dialog h3').html '<i class="glyphicon glyphicon-pencil"></i> <%= t("products.edit_product") %>'
# Render the edit form
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

# cache the select element as we'll be using it a few times
select = $('#products_select')
# init the chosen plugin
select.chosen()
# get the chosen object
chosen = select.data('chosen')
# Bind the keyup event to the search box input
chosen.dropdown.find('input').on 'keyup', (e) ->
  # if we hit Enter and the results list is empty (no matches) add the option
  if e.which == 13 and chosen.dropdown.find('li.no-results').length > 0
    option = $('<option id="0">').val(@value).text(@value)
    # add the new option
    select.prepend option
    # automatically select it
    select.find(option).prop 'selected', true
    # trigger the update
    select.trigger 'chosen:updated'
$('.addpict').simpleCropper()

$(document).ready ->
  $('.chosen-select').on 'change', ->
    if $('#factories_select option:selected').val() and $('#products_select option:selected').val() and $('#product_type_furniture_id option:selected').val()
      $('input[name=commit]').prop 'disabled', false
    else
      $('input[name=commit]').prop 'disabled', true
    return
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