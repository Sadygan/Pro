json.array!(@clients) do |client|
  json.extract! client, :id, :name, :company, :status_position, :telephone, :email, :address
  json.url client_url(client, format: :json)
end
