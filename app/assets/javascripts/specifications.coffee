#$ ->
#  $(document).on 'click', '#print_sum', (evt) ->
#    print = $('#print_sum').prop('checked')
#    specification_id = "<%= @table_specification %>"
#    console.log("sp: "+specification_id)
#    url = 'table_specification/table_specifications/update_print_sum'
#    p = 'specification': 'print_sum': print
#    printSum p, specification_id, url
#    return

#printSum = (print, specification_id, url) ->
#  console.log print
  # var p = {'specification': {'print_sum': print}};
#  $.ajax
#    url: url
#    type: 'PUT'
#    dataType: 'json'
#    data: print
#    async: true
#    error: ->
      # alert("Войдите через страницу проекты")
#      return
#   success: (data) ->
#  return

$ ->
  $(document).on 'click', '#print_sum', (evt) ->
    $.ajax 'table_specifications/table_specification/update_print_sum',
      type: 'GET'
      dataType: 'script'
      data: {
        print_sum: $('#print_sum').prop('checked')
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
    return false