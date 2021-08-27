class User < ApplicationRecord
  # Associations
  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy
end
