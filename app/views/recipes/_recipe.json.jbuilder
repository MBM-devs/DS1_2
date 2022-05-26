json.extract! recipe, :id, :name, :people, :duration, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
