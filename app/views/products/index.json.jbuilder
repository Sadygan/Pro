json.array!(@products) do |product|
  json.extract! product, :id, :article
  json.url product_url(product, format: :json)
end
