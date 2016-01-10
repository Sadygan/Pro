jQuery ->
  $('.best_in_place').best_in_place()
$ ->
  $(document).on 'click', '.photos a', (evt) ->
    $.ajax 'table_specification/photos',
      type: 'GET'
      dataType: 'script'
      data: {
        product_id: $(invoker).closest('tr').attr("product-id")
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
    return false
$ ->
  $(document).on 'click', '.size_images a', (evt) ->
    $.ajax 'table_specification/size_images',
      type: 'GET'
      dataType: 'script'
      data: {
        product_id: $(invoker).closest('tr').attr("product-id")
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
    return false
$ ->
  $(document).on 'click', '.factory a.invoker', (evt) ->
    $.ajax 'table_specification/discounts',
      type: 'GET'
      dataType: 'script'
      data: {
        factory_id: $(invoker).attr("id")
        row_id: $(invoker).closest('tr').attr("row-id")
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
    return false
$ ->
  $(document).on 'click', '.v.v_table a.deliv.invoker', (evt) ->
    $.ajax 'table_specification/deliveries',
      type: 'GET'
      dataType: 'script'
      data: {
        row_id: $(invoker).closest('tr').attr("row-id")
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("articles change")
    return false
$ ->
  $(document).on 'click', 'a.shvg_percent, a.shvg.invoker', (evt) ->
    $.ajax 'table_specification/packing_sizes',
      type: 'GET'
      dataType: 'script'
      data: {
        product_id: $(invoker).closest('tr').attr("product-id")
        id: $(invoker).closest('tr').attr("row-id")
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("articles change")
        console.log($(invoker).closest('tr').attr("product-id"))
    return false


#$ ->
#  $(document).on 'click', '#print_sum', (evt) ->
#    print = $('#print_sum').prop('checked')
#    specification_id = parseInt($('.specification_id').text())
#    full_url = window.location.href
#    url = './' + specification_id
#    console.log(window.location.href)
#    p = 'specification': 'print_sum': print
#    printSum p, specification_id, url
#    return

$(document).ready ->
  client = new (Dropbox.Client)(
    key: 'oqe1u2h3676wzpc'
    secret: '6d38819v60m67c1'
    token: 'yza6vaucz0yy8eeb'
    user: '489572075'
    sandbox: false)
  client.isAuthenticated()
  return

