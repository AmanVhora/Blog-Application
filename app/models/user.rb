class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :blogs, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :likes
  validates :user_name, presence: true, uniqueness: true

  private

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at email user_name]
  end
end
