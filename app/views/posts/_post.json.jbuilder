json.extract! post, :id, :user_id, :text, :recipe_id, :user_id, :list_id, :created_at, :updated_at
json.url post_url(post, format: :json)