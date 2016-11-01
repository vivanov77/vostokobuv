json.array!(@component_types) do |component_type|
  json.extract! component_type, :id
  json.url component_type_url(component_type, format: :json)
end
