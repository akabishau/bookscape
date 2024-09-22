class Book < ApplicationRecord
  has_many :user_books, dependent: :restrict_with_exception
  has_many :users, through: :user_books
  has_many :reviews, through: :user_books

  validates :title, :google_id, presence: true
  validates :google_id, uniqueness: true

  def reading_status_for(user)
    user_books.find_by(user: user)&.status # default value?
  end
end
