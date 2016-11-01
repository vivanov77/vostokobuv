json.array!(@component_category_values) do |component_category_value|
  json.extract! component_category_value, :id
  json.url component_category_value_url(component_category_value, format: :json)
end
