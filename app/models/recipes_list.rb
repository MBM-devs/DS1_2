class RecipesList < ApplicationRecord
  belongs_to :list
  belongs_to :recipe
end
