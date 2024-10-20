class HomeController < ApplicationController
  def index
    # TODO: reorder groups by applying a custom order
    @books_by_status = current_user.user_books.includes(:book).group_by(&:status)
  end
end
