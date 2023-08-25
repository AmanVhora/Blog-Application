class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, presence: true

  private

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at content]
  end
end
