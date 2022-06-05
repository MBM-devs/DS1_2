class AddIngredientIdToRecipeIngredients < ActiveRecord::Migration[7.0]
  def change
      # add_column :recipe_ingredients, :ingredient_id, :bigint
      add_foreign_key :recipe_ingredients, :ingredients
  end
end
