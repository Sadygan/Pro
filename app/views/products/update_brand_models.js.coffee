$("#products_select").empty()
  .append("<%= escape_javascript(render(partial: 'products/brand_model/form', collection: @brand_models, as: 'brand_model')) %>")

# reseting model chosen after change factory
$("#products_select").prepend("<option value='' selected='selected'></option>");
$('#products_select').trigger('chosen:updated')

