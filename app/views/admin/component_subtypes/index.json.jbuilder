json.array!(@component_subtypes) do |component_subtype|
  json.extract! component_subtype, :id
  json.url component_subtype_url(component_subtype, format: :json)
end
