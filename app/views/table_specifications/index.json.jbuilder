json.array!(@table_specifications) do |table_specification|
  json.extract! table_specification, :id, :factory_brand, :article, :type_fyrniture, :finishing, :finishing_for_client, :size, :weight, :width, :height, :depth, :percent_v, :unit_price_factory, :increment_discount, :unit_price_netto, :summ_netto, :unit_v, :factor, :unit_price, :number_of, :summ, :required, :specification_id
  json.url project_specification_table_specification_url(@project, @specification, table_specification, format: :json)
end
