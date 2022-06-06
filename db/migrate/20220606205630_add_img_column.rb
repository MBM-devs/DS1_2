class AddImgColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :url_img, :string
  end
end
