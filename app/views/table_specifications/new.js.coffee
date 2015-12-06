$('.table-button').hide().after("<%= j render 'form' %>");
$ ->
  $(document).on 'change', '#factories_select', (evt) ->
    $.ajax 'table_specification/update_products',
      type: 'GET'
      dataType: 'script'
      data: {
        factory_id: $("#factories_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic country select OK!")
        console.log(data)