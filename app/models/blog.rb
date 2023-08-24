class Blog < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :comments, as: :commentable
  has_many :likes, as: :likable
  has_one_attached :cover_image

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  validates :cover_image, presence: true
end
