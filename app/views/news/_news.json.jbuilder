json.extract! news, :id, :title, :content, :sent, :created_at, :updated_at
json.url news_url(news, format: :json)