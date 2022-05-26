json.extract! shopping_list, :id, :user_id, :ingredient_id, :comprado, :created_at, :updated_at
json.url shopping_list_url(shopping_list, format: :json)
