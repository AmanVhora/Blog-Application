class PostCategory < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :posts

  private

  def self.ransackable_associations(auth_object = nil)
    %w[posts]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at name]
  end
end
