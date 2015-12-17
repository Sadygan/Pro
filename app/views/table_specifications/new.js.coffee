$('.table-button').hide().after("<%= j render 'form' %>");
invoker = undefined
$ ->
  $(document).on 'change', '#factories_select', (evt) ->
    console.log('ok')
    $.ajax 'table_specification/update_brand_models',
      type: 'GET'
      dataType: 'script'
      data: {
        factory_id: $("#factories_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic country select OK!")
$ ->
  $(document).on 'change', '#products_select', (evt) ->
    $.ajax 'table_specification/update_articles',
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
    $.ajax 'table_specification/update_pipe_article',
      type: 'GET'
      dataType: 'script'
      data: {
        product_id: $("#articles_select option:selected").attr("id")
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("articles change")
$ ->
  $(document).on 'click', '#number_discount a', (evt) ->
    $.ajax 'table_specification/discounts',
      type: 'GET'
      dataType: 'script'
      data: {
        factory_id: $("#number_discount a").attr("id")
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("articles change")
$ ->
  $(document).on 'click', '#photos a', (evt) ->
    $.ajax 'table_specification/photos',
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
$ ->
  $(document).on 'click', '#size_images a', (evt) ->
    $.ajax 'table_specification/size_images',
      type: 'GET'
      dataType: 'script'
      data: {
        product_id: $("#articles_select option:selected").attr("id")
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        product_id: $("#articles_select option:selected").attr("id")
        console.log("Dynamic country select OK!4444")
  
  $('.chosen-select').chosen
    allow_single_deselect: false
    no_results_text: 'Add to Data Base'
    width: '110px'

