class Book < ApplicationRecord
  has_many :user_books, dependent: :restrict_with_exception

  validates :title, :google_id, presence: true
  validates :google_id, uniqueness: true
end
