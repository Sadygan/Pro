json.array!(@brand_models) do |brand_model|
  json.extract! brand_model, :id, :name
  json.url brand_model_url(brand_model, format: :json)
end
