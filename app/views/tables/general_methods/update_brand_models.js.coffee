$("#products_select").empty()
  .append("<%= escape_javascript(render(partial: 'tables/general_methods/brand_model/form', collection: @brand_models, as: 'brand_model')) %>")

unless $("#number_discount") != []
  $("#number_discount").empty()
    .append("<%= escape_javascript(render(partial: 'tables/general_methods/discount/percent', as: 'discount')) %>")

# reseting model chosen after change factory
$("#products_select").prepend("<option value='' selected='selected'></option>");
$('#products_select').trigger('chosen:updated')

# Show Brand -> factory_light in select preview
$("#list_factor").empty()
  .append("<%= escape_javascript(render(partial: 'tables/general_methods/list_factor/form', collection: @discount_lights, as: 'discount_light')) %>")

# add record to list search in model field
select = undefined
chosen = undefined
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
    # updating article list
    $.ajax '/tables/update_articles',

      type: 'GET'
      dataType: 'script'
      data: {
      }
      error: (jqXHR, textStatus, errorThrown) ->
      success: (data, textStatus, jqXHR) ->
  
    $('#articles_select').trigger('chosen:updated')
  return
$ ->
  $('#list_factor').on 'click', (event) ->
    $('#factor_light').val($(this).val())

