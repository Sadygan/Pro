$("#products_select").empty()
  .append("<%= escape_javascript(render(partial: 'brand_model', collection: @brand_models, layout: 'brand_model')) %>")

# Remove duplicate in model chosen
usedNames = {}
$('#products_select > option').each ->
  if usedNames[@text]
    $(this).remove()
  else
    usedNames[@text] = @value
  return

# reseting model chosen after change factory
$("#products_select").prepend("<option value='' selected='selected'></option>");
$('#products_select').trigger('chosen:updated')

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
    option = $('<option>').val(@value).text(@value)
    # add the new option
    select.prepend option
    # automatically select it
    select.find(option).prop 'selected', true
    # trigger the update
    select.trigger 'chosen:updated'
    # updating article list
    $.ajax 'table_specification/update_articles',
      type: 'GET'
      dataType: 'script'
      data: {
        model: $("#products_select option:selected").html().toLowerCase()
      }
      error: (jqXHR, textStatus, errorThrown) ->
      success: (data, textStatus, jqXHR) ->
    $('#articles_select').trigger('chosen:updated')
  return


