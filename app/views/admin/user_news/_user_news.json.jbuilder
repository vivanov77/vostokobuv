json.extract! user_news, :id, :title, :content, :delta, :user_id, :created_at, :updated_at
json.url user_news_url(user_news, format: :json)