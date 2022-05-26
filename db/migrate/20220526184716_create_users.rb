class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: false, primary_key: :username do |t|
      t.string :username, null:false
      t.string :email, null:false
      t.string :password, null:false

      t.timestamps
    end
  end
end
