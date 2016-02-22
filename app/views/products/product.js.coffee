$ ->
  loading_products = false
  $('a.load-more-products').on 'inview', (e, visible) ->
    return if loading_products or not visible
    loading_products = true
    
    $.getScript $(this).attr('href'), ->
      loading_products = false