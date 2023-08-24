class Blog < ApplicationRecord
  belongs_to :user
  has_one_attached :cover_image

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  validates :cover_image, presence: true
end
