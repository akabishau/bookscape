class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @quote = "\"If you don’t like to read, you haven’t found the right book.\""
    @author = "– J.K. Rowling"

    # fetch all books grouped by status avoing N+1 queries
    @books_by_status = current_user.user_books.includes(:book).group_by(&:status)
    @books_by_status.each do |status, user_books|
      @books_by_status[status] = user_books.map(&:book)
    end
  end
end
