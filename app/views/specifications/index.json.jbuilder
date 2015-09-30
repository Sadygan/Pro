json.array!(@specifications) do |specification|
  json.extract! specification, :id, :name, :style, :summ, :project_id
  json.url project_specifications_path(specification, format: :json)
end
