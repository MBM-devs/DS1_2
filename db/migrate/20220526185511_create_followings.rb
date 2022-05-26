class CreateFollowings < ActiveRecord::Migration[7.0]
  def change
    
    create_table :followings do |t|
      t.bigint :follower, foreign_key: true, null: false
      t.bigint :followed, foreign_key: true, null: false

      t.timestamps
    end
    execute "ALTER TABLE followings ADD CONSTRAINT follower_fk FOREIGN KEY (follower) REFERENCES users (id);"
    execute "ALTER TABLE followings ADD CONSTRAINT followed_fk FOREIGN KEY (followed) REFERENCES users (id);"
  end
end
