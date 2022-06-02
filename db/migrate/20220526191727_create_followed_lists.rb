class CreateFollowedLists < ActiveRecord::Migration[7.0]
  def change
    create_table :followed_lists do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :list, null: false, foreign_key: true

      t.timestamps
    end
  end
end