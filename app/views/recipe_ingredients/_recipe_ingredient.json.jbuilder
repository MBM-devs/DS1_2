json.extract! recipe_ingredient, :id, :receta_id, :quantity, :unit, :created_at, :updated_at
json.url recipe_ingredient_url(recipe_ingredient, format: :json)
