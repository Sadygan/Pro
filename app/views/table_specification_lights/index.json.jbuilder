json.array!(@table_specification_lights) do |table_specification_light|
  json.extract! table_specification_light, :id, :finishing, :finishing_for_client, :unit_price_factory, :width, :height, :depth, :number_of, :interest_percent, :arhitec_percent
  json.url table_specification_light_url(table_specification_light, format: :json)
end
