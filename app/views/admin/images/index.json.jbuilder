json.array!(@images) do |image|
  json.extract! image, :id, :imageable_id, :file
  json.url image_url(image, format: :json)
end
