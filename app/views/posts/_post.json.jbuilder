json.extract! post, :id, :user_id, :recipe_id, :following_id, :list_id, :created_at, :updated_at
json.url post_url(post, format: :json)
