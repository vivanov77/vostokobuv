json.array!(@component_category_types) do |component_category_type|
  json.extract! component_category_type, :id
  json.url component_category_type_url(component_category_type, format: :json)
end
