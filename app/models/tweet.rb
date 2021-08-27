class Tweet < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :comments, dependent: :destroy
  # Validations
  validates :body, presence: true, length: { maximum: 140 }
end
