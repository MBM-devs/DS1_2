class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :text
      t.belongs_to :recipe, foreign_key: true
      t.belongs_to :following, foreign_key: true
      t.belongs_to :list, foreign_key: true

      t.timestamps
    end
  end
end
