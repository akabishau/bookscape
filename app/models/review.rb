class Review < ApplicationRecord
  # TODO: explore why not to have review_id in the user_books table
  belongs_to :user_book # ? dependent: :destroy

  validates :rating, presence: true
  validates :comment, length: { maximum: 1000 }
end
