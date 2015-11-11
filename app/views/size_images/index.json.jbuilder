json.array!(@size_images) do |size_image|
  json.extract! size_image, :id, :type, :img_file_name, :img_url
  json.url product_size_image_url(@product, size_image, format: :json)
end
