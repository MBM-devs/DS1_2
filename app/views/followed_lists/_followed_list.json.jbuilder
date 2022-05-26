json.extract! followed_list, :id, :user_id, :list_id, :created_at, :updated_at
json.url followed_list_url(followed_list, format: :json)
