class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.bigint :recipe_id
      t.bigint :following_id
      t.bigint :list_id

      t.timestamps
    end
  end
end
