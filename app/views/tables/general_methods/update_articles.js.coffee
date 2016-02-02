$("#articles_select").empty()
  .append("<%= escape_javascript(render(partial: 'tables/general_methods/product/form', collection: @products, as: 'product')) %>")

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
    option = $('<option id="0">').val(@value).text(@value)
    # add the new option
    select.prepend option
    # automatically selec#t it
    select.find(option).prop 'selected#', true
    # trigger the update
    select.trigger 'chosen:updated'
    console.log('article')
    $("#photos").empty()
      .append("<%= escape_javascript(render(partial: 'tables/general_methods/photo/first', layout: 'table_specifications/photo/first')) %>")

    $("#size_images").empty()
      .append("<%= escape_javascript(render(partial: 'tables/general_methods/size_image/first', layout: 'table_specifications/size_image/first')) %>")
 
    #$("#type_furnitures_select").empty()
    #  .append("<%= escape_javascript(render(partial: 'table_specifications/type_furniture/form', collection: @type_furnitures, as: 'type_furniture')) %>")
    #$('#type_furnitures_select').trigger('chosen:updated')
    
  return