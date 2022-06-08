class FksPosts < ActiveRecord::Migration[7.0]
  def change
    class FksPosts < ActiveRecord::Migration[7.0]
      def change
        add_foreign_key :posts, :recipes, column: :recipe_id, on_delete: :cascade, optional: true
        add_foreign_key :posts, :lists, column: :list_id, on_delete: :cascade, optional: true
        add_foreign_key :posts, :followings, column: :following_id, on_delete: :cascade, optional: true
      end
    end    
  end
end
