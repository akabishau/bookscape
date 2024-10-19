class Book < ApplicationRecord
  has_many :user_books
  has_many :users, through: :user_books

  validates :title, :google_id, presence: true
  validates :google_id, uniqueness: true
end
