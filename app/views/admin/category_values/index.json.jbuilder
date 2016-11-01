json.array!(@category_values) do |category_value|
  json.extract! category_value, :id, :title
  json.url category_value_url(category_value, format: :json)
end
