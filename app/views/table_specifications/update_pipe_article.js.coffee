PERCENT_PACK = 15
$("#photos").empty()
  .append("<%= escape_javascript(render(partial: 'table_specifications/photo/first', layout: 'table_specifications/photo/first')) %>")

$("#size_images").empty()
  .append("<%= escape_javascript(render(partial: 'table_specifications/size_image/first', layout: 'table_specifications/size_image/first')) %>")

$("#factories_select").empty()
  .append("<%= escape_javascript(render(partial: 'table_specifications/factory/form', collection: @factories, as: 'factory')) %>")
$('#factories_select').trigger('chosen:updated')

$("#products_select").empty()
  .append("<%= escape_javascript(render(partial: 'table_specifications/brand_model/form', collection: @brand_models, as: 'brand_model')) %>")
if $("#products_select option").length == 0
  $("#products_select").append('<option value="<%= @br %>" id="0" selected="selected" ><%= @br %></option>')
$('#products_select').trigger('chosen:updated')
console.log('update_pipe')

$("#product_type_furniture_id").empty()
  .append("<%= escape_javascript(render(partial: 'table_specifications/type_furniture/form', collection: @type_furnitures, as: 'type_furniture')) %>")
$('#product_type_furniture_id').trigger('chosen:updated')

$("#number_discount").empty()
  .append("<%= escape_javascript(render(partial: 'table_specifications/discount/percent', as: 'discount')) %>")

# V 
shvg = parseFloat("<%= @product.shvg %>")
unit_v = parseFloat("<%= @product.unit_v %>")
console.log("uv:"+unit_v)
console.log("svg: "+shvg)
if isNaN(unit_v)
  console.log("unit_v == ''")
  $("#uv").empty()
    .append('<input step="0.01" class="unit_v" value="0" type="number" name="product[unit_v]" id="product_unit_v">')
if unit_v > 0
  console.log("unit_v > 0")
  $("#uv").empty()
    .append("<%= @product.unit_v %>")
  $("#shvg").empty()
if shvg > 0
  console.log("shvg > 0")
  $("#uv").empty()
    .append(shvg+shvg*PERCENT_PACK/100)
  $("#shvg").empty()
    .append('<a class="shvg_percent invoker" href="#">ШВГ</a>')
  $('#table_specification_percent_v').val(PERCENT_PACK)
if isNaN(unit_v) && shvg == 0
  console.log('unit_v == "" && shvg')
  $("#uv").empty()
    .append('<input step="0.01" class="unit_v" value="0" type="number" name="product[unit_v]" id="product_unit_v">')
  $("#shvg").empty()
    .append('<a class="shvg invoker" href="#">ШВГ</a>')
  $('#table_specification_percent_v').val("")



# add record to list search in model field
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
    $.ajax 'table_specification/update_articles',
      type: 'GET'
      dataType: 'script'
      data: {
      }
      error: (jqXHR, textStatus, errorThrown) ->
      success: (data, textStatus, jqXHR) ->

    $('#articles_select').trigger('chosen:updated')

  return

# тут костыль нужно поправить переписать через контроллер
img_size = 0
discount_id = 0
img_size = $("#size_images img").attr('value')
$("#table_specification_size_image_id").val(img_size)
discount_id = $("#number_discount a").attr('discount-id')
$("#table_specification_discount_id").val(discount_id)
console.log(discount_id)
########################################################