$("#photos").empty()
  .append("<%= escape_javascript(render(partial: 'table_specifications/photo/first', layout: 'table_specifications/photo/first')) %>")

$("#size_images").empty()
  .append("<%= escape_javascript(render(partial: 'table_specifications/size_image/first', layout: 'table_specifications/size_image/first')) %>")

$("#products_select").empty()
  .append("<%= escape_javascript(render(partial: 'table_specifications/brand_model/form', collection: @brand_models, as: 'brand_model')) %>")
$('#products_select').trigger('chosen:updated')

$("#factories_select").empty()
  .append("<%= escape_javascript(render(partial: 'table_specifications/factory/form', collection: @factories, as: 'factory')) %>")
$('#factories_select').trigger('chosen:updated')

$("#type_furnitures_select").empty()
  .append("<%= escape_javascript(render(partial: 'table_specifications/type_furniture/form', collection: @type_furnitures, as: 'type_furniture')) %>")
$('#type_furnitures_select').trigger('chosen:updated')

$("#number_discount").empty()
  .append("<%= escape_javascript(render(partial: 'table_specifications/discount/percent', as: 'discount')) %>")