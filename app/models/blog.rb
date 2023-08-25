class Blog < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_one_attached :cover_image

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  validates :cover_image, presence: true

  private

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at title]
  end
end
