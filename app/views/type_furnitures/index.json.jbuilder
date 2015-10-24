json.array!(@type_furnitures) do |type_furniture|
  json.extract! type_furniture, :id, :name
  json.url type_furniture_url(type_furniture, format: :json)
end
