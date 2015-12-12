$("#articles_select").empty()
  .append("<%= escape_javascript(render(partial: 'product', collection: @products, layout: 'product')) %>")

usedNames = {}
$('#articles_select > option').each ->
  if usedNames[@text]
    $(this).remove()
  else
    usedNames[@text] = @value
  return

$("#articles_select").prepend("<option value='' selected='selected'></option>");
$('#articles_select').trigger('chosen:updated')

select = undefined
chosen = undefined
# cache the select element as we'll be using it a few times
select = $('#articles_select')
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

  return


