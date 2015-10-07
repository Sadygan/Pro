json.array!(@assets) do |asset|
  json.extract! asset, :id, :type, :img, :product_id
  json.url asset_url(asset, format: :json)
end
