json.array!(@projects) do |project|
  json.extract! project, 
	:object_name, 
	:style, 
	:type_furniture, 
	:date_request, 
	:deadline, 
	:planned_budget, 
	:date_delivery_client, 
	:amount_contract, 
	:client_prepayment,
	:factory_prepayment,
	:client_surcharge,
	:factory_surcharge,
	:status_transaction,
	:delivery_status,
	:user_id,
	:city_id,
	:style_id,
	:client_id,
	:print_sum
  json.url project_url(project, format: :json)
end
