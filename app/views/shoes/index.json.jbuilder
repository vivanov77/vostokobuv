json.array!(@shoes) do |shoe|
  json.extract! shoe, :id, :title
  json.url shoe_url(shoe, format: :json)
end
