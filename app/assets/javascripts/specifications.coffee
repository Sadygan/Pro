$ ->
  $(document).on 'click', '#print_sum', (evt) ->
    print = $('#print_sum').prop('checked')
    specification_id = "<%= @table_specification %>"
    console.log("sp: "+specification_id)
    url = '../'
    p = 'specification': 'print_sum': print
    printSum p, specification_id, url
    return

printSum = (print, specification_id, url) ->
  console.log print
  # var p = {'specification': {'print_sum': print}};
  $.ajax
    url: url
    type: 'PUT'
    dataType: 'json'
    data: print
    async: true
    error: ->
      # alert("Войдите через страницу проекты")
      return
    success: (data) ->
  return