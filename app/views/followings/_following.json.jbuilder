json.extract! following, :id, :follower, :followed, :created_at, :updated_at
json.url following_url(following, format: :json)
