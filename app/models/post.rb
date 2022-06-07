class Post < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  belongs_to :user
  belongs_to :list
end
