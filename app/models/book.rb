class Book < ApplicationRecord
  validates :title, :google_id, presence: true
  validates :google_id, uniqueness: true
end
