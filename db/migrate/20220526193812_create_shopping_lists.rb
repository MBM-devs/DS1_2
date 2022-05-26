class CreateShoppingLists < ActiveRecord::Migration[7.0]
  def change
    create_table :shopping_lists do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :ingredient, null: false, foreign_key: true
      t.boolean :comprado

      t.timestamps
    end
  end
end
