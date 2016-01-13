#$('.table-button').hide()
#$('#table_specification tr:last').after("<%= j render 'form' %>")
$('.table-button').hide().after("<%= j render 'form' %>")

$('input').on 'change keyup',(evt) ->
  calculate($(this))

$('.chosen-select').chosen
  allow_single_deselect: false
  no_results_text: 'Add to Data Base'
  width: '110px'

$('textarea').autoResize
  extraSpace : 0

$ ->
  $(document).on 'change', '#factories_select', (evt) ->
    console.log('ok')
    $.ajax 'table_specifications/table_specification/update_brand_models',
      type: 'GET'
      dataType: 'script'
      data: {
        factory_id: $("#factories_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("discount ok!")
        factory_id_ = $('#number_discount a').attr('discount-id')
        console.log(factory_id_)
        $('#table_specification_discount_id').val(factory_id_)
        $('input[name=create_ts]').prop('disabled', true);
$ ->
  $(document).on 'change', '#products_select', (evt) ->
    $.ajax 'table_specifications/table_specification/update_articles',
      type: 'GET'
      dataType: 'script'
      data: {
        brand_model_id: $("#products_select option:selected").attr("id")
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
$ ->
  $(document).on 'change', '#articles_select', (evt) ->
    article = 0
    article = $("#articles_select option:selected").attr("id")
    $.ajax 'table_specifications/table_specification/update_pipe_article',
      type: 'GET'
      dataType: 'script'
      data: {
        product_id: article
        brand_model_id: $("#products_select option:selected").attr("id")
        brand_model_val: $("#products_select option:selected").val()
        factory_id: $("#factories_select option:selected").val()
        type_furniture_id: $("#type_furnitures_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        $('#table_specification_product_id').val(article)
        $('#table_specification_photo_id').val($("#photos img").attr('value'))
        $('input[name=create_ts]').prop('disabled', false);
$ ->
  $(document).on 'click', '#number_discount a', (evt) ->
    $.ajax 'table_specifications/table_specification/discounts',
      type: 'GET'
      dataType: 'script'
      data: {
        factory_id: $("#number_discount a").attr("id")
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        increment = $(invoker).closest('tr').find('.table_specification_increment_discount').val();
        $('.increment_discount_modal').val(increment);
        current_discount_id = $('#table_specification_discount_id').val()
        $('.discounts [value='+current_discount_id+']').attr('selected', 'selected')
    return false
$ ->
  $(document).on 'click', 'a#delivery', (evt) ->
    $.ajax 'table_specifications/table_specification/deliveries',
      type: 'GET'
      dataType: 'script'
      data: {
        # delivery_id: $('#table_specification_delivery_id').val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("articles change")
        current_delivery_id = $('#table_specification_delivery_id').val()
        $('.deliveries [value='+current_delivery_id+']').attr('selected', 'selected')
    return false
$ ->
  $(document).on 'click', 'form a.shvg, a.shvg_percent', (evt) ->
    $.ajax 'table_specifications/table_specification/packing_sizes',
      type: 'GET'
      dataType: 'script'
      data: {
        product_id: $('#articles_select option:selected').attr("id")
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("articles change")
    return false
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

$ ->
  $(document).on 'click', '#size_images a', (evt) ->
    $.ajax 'table_specifications/table_specification/size_images',
      type: 'GET'
      dataType: 'script'
      data: {
        product_id: $("#articles_select option:selected").attr("id")
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        product_id: $("#articles_select option:selected").attr("id")
    return false

$ ->
  $(document).on 'click', '#modaldelivery .btn-primary', (evt) ->
    $.ajax 'table_specifications/table_specification/delivery_data',
      type: 'GET'
      dataType: 'script'
      data: {
        delivery_id: $("#post_delivery_id option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log(invoker)
        calculate(invoker)
    return false

$ ->
  $(document).on 'change', '.chosen-select', (evt) ->
    console.log 'change'
    if $('#factories_select option:selected').val() and $('#products_select option:selected').val() and $('#articles_select option:selected').val()
      $('input[name=create_ts]').prop 'disabled', false
    else
      $('input[name=create_ts]').prop 'disabled', true
    return

#$('#table_specification_size_image_id').val(base64)