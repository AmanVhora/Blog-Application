class Post < ApplicationRecord
  belongs_to :post_category
  belongs_to :blog
  has_many :comments
  has_many :likes
  has_one_attached :post_image

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
  
  private

  def self.ransackable_associations(auth_object = nil)
    %w[likes post_category]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at title post_category_id]
  end
end
