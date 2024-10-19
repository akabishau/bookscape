class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum status: {
    to_add: 0, # TODO: should be default? review when working with FE
    want: 1,
    reading: 2,
    finished: 3,
    paused: 4,
    dropped: 5
  }

  # TODO: review use-case of using validates_associated

  validates :user, :book, :status, presence: true
  validates :user_id, uniqueness: { scope: :book_id, message: "user has only one entry for each book" }
  validates :status, inclusion: { in: statuses.keys }
end
