class Review < ApplicationRecord
  belongs_to :user_book

  validates :rating, presence: true
  validates :comment, length: { maximum: 1000 }
end
