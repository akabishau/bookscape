class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum status: { want_to_read: 0, reading: 1, read: 2 }

  before_validation :set_default_status, on: :create

  validates :user, :book, :status, presence: true

  private

  def set_default_status
    self.status ||= :want_to_read
  end
end
