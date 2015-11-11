json.array!(@photos) do |photo|
  json.extract! photo, :id, :type, :img_file_name, :img_url
  json.url product_photo_url(@product, photo, format: :json)
end
