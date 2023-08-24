class PostCategory < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :posts
end
