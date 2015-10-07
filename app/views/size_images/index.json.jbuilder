json.array!(@size_images) do |size_image|
  json.extract! size_image, :id
  json.url size_image_url(size_image, format: :json)
end
