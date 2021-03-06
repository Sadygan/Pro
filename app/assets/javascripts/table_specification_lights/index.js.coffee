#= require tables/general_methods.js
$ ->
  $('#form_button_light').click()
  activateBestInPlace '[data-bip-attribute="unit_price_factory"]', 'light_table'
  activateBestInPlace '[data-bip-attribute="number_of"]', 'light_table'
  activateBestInPlace '[data-bip-attribute="interest_percent"]', 'light_table'
  activateBestInPlace '[data-bip-attribute="arhitec_percent"]', 'light_table'
  calculateLight $('input:first')
  $('body').on 'change keyup', 'input', ->
    calculateLight $(this)
    console.log $(this)
    return
  $(document).on 'click', 'a.invoker', ->
    invoker = $(this)
    return
  $('body').on 'click', '#modalpict a', ->
    $('#modalpict').modal 'hide'
    imgsrc = $(this).find('img').attr('src')
    $(invoker).find('img').attr 'src', imgsrc
    # Change value in photo_id and base64
    imgval = $(this).find('img').attr('value')
    if imgsrc.substring(0, 10) != 'data:image'
      $(invoker).find('img').attr 'value', imgval
      $('#table_specification_light_photo_id').val imgval
      $('#table_specification_light_photo_base64_form').val ''
    else
      # Add photos in this product
      row_id = $(invoker).closest('tr').attr('row-id')
      product_id = $(invoker).closest('tr').attr('product-id')
      if product_id != undefined
        $(invoker).closest('tr').find('.id_table').val row_id
        $(invoker).closest('tr').find('.product_id_table').val product_id
        $(invoker).closest('tr').find('.base64_table').val imgsrc
        $(invoker).closest('tr').find('input[name=add_photos]').trigger 'click'
      $(invoker).find('img').attr 'value', ''
      $('#table_specification_light_photo_base64_form').val imgsrc
      $('#table_specification_light_photo_id').val ''
    false
  $('body').on 'click', '#modalsize a', ->
    $('#modalsize').modal 'hide'
    imgsrc = $(this).find('img').attr('src')
    $(invoker).find('img').attr 'src', imgsrc
    $('#table_specification_light_size_image_base64_form').val imgsrc
    # Change value in photo_id and base64
    imgval = $(this).find('img').attr('value')
    if imgsrc.substring(0, 10) != 'data:image'
      $('#table_specification_light_size_image_id').val imgval
      $('#table_specification_light_size_image_base64_form').val ''
    else
      # Add size image in this product
      product_id = $(invoker).closest('tr').attr('product-id')
      row_id = $(invoker).closest('tr').attr('row-id')
      if product_id != undefined
        $(invoker).closest('tr').find('.id_table').val row_id
        $(invoker).closest('tr').find('.product_id_table').val product_id
        $(invoker).closest('tr').find('.base64_table').val imgsrc
        $(invoker).closest('tr').find('input[name=add_size_images]').trigger 'click'
      $(invoker).find('img').attr 'value', imgval
      # $(invoker).find('img').attr('value', '');
      $('#table_specification_light_size_image_base64_form').val imgsrc
      $('#table_specification_light_size_image_id').val ''
    false
  return

# ---
# generated by js2coffee 2.1.0