<% js = escape_javascript(
  render(partial: 'products/list', locals: { products: @products })
) %>

$("#results").html("<%= js %>");


