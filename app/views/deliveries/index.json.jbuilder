json.array!(@deliveries) do |delivery|
  json.extract! delivery, :id, :direction, :cost, :execution_document, :check_factory, :bank_service, :bank_percent
  json.url delivery_url(delivery, format: :json)
end
