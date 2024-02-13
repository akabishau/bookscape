class HomeController < ApplicationController
  def index
    @quote = "\"If you don’t like to read, you haven’t found the right book.\""
    @author = "– J.K. Rowling"

    # fetch all books grouped by status avoing N+1 queries
    # @books_by_status = current_user.user_books.includes(:book).group_by(&:status)
    # @books_by_status.each do |status, user_books|
    #   @books_by_status[status] = user_books.map(&:book)
    # end
    # Rails.logger.info("Books by status for HOME: #{@books_by_status}")

    books = UserBookService.group_user_books_by_status(current_user)
    Rails.logger.info("Books by status for HOME: #{@books}")
    @books_by_status = books
  end
end
