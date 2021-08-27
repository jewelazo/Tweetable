class User < ApplicationRecord
  # Associations
  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  # Validations
  validates :username, :email, presence: true, uniqueness: true
  validates :name, presence: true
end
