$ ->
  $(document).on 'click', '#specifications input', (evt) ->
    $.ajax '/tables/update_print_sum',
      type: 'GET'
      dataType: 'script'
      data: {
        print_sum: $(this).prop('checked');
        specification_id: $(this).val();
      }
      error: (jqXHR, textStatus, errorThrown) ->
      success: (data, textStatus, jqXHR) ->

    return false