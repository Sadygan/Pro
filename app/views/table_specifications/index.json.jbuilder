json.array!(@table_specifications) do |table_specification|
  json.extract! table_specification, 
  		  :id, 
          :finishing, 
          :finishing_for_client,
          :unit_price_factory,
          :increment_discount,
          :size,
          :weight, 
          :width, 
          :height, 
          :depth, 
          :percent_v, 
          :unit_v,
          :factor,
          :number_of,
          :interest_percent,
          :arhitec_percent,
          :group,
          :additional_delivery,
          :required,
         
          :specification_id, 
          :factory_brand,
          :factory_id, 
          :discount_id,
          :delivery_id, 
 	
          :photo_id,
          :size_image_id,
          :product_id
  json.url project_specification_table_specification_url(@project, @specification, table_specification, format: :json)
end
