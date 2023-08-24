class Post < ApplicationRecord
  belongs_to :post_category
  belongs_to :blog
  has_many :comments, as: :commentable
  has_many :likes, as: :likable
  has_one_attached :post_image

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
end