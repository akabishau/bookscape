class HomeController < ApplicationController
  def index
    @quote = "\"If you don’t like to read, you haven’t found the right book.\""
    @author = "– J.K. Rowling"

    # books = UserBookService.group_user_books_by_status(current_user)
    # Rails.logger.info("Books by status for HOME: #{@books}")
    # @books_by_status = books

    @books_by_status = current_user.user_books.includes(:book).group_by(&:status)
  end
end

# TODO: review the service implementation and use standard Rails methods
