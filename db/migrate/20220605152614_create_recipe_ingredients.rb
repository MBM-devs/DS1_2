class CreateRecipeIngredients < ActiveRecord::Migration[7.0]
  def change
    drop_table :recipe_ingredients
    create_table :recipe_ingredients do |t|
      t.belongs_to :recipe, null: false, foreign_key: true
      t.belongs_to :ingredient, null: false, foreign_key: true
      t.integer :quantity
      t.string :unit

      t.timestamps
    end
  end
end
