$('.table-button').hide().after("<%= j render 'form' %>");
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
        console.log($("#products_select option:selected").attr("id"))
        console.log("Dynamic country select OK!1111")

  $('.chosen-select').chosen
    allow_single_deselect: false
    no_results_text: 'Add to Data Base'
    width: '200px'

