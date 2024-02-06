class Book < ApplicationRecord
  has_many :user_books, dependent: :restrict_with_exception

  validates :title, :author, :description, presence: true
end
