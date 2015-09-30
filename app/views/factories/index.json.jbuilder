json.array!(@factories) do |factory|
  json.extract! factory, :id, :brand, :web, :autorification, :style, :line_product, :catalog, :price, :discount, :additional_discount, :delivery_terms, :note
  json.url factory_url(factory, format: :json)
end
