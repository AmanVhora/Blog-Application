class Post < ApplicationRecord
  belongs_to :post_category
  belongs_to :blog
  has_many :comments
  has_many :likes
  has_one_attached :post_image

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
end
