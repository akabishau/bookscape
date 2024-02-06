class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_books, dependent: :delete_all
  has_many :books, through: :user_books
end
