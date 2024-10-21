class HomeController < ApplicationController
  def index
    # TODO: reorder groups by applying a custom order
    # TODO: review sending only relevant data to the view
    @books_by_status = current_user.user_books.includes(:book).group_by(&:status)
  end
end
