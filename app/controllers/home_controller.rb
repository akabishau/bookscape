class HomeController < ApplicationController
  def index
    @quote = "\"If you don’t like to read, you haven’t found the right book.\""
    @author = "– J.K. Rowling"
    @books_by_status = current_user.user_books.includes(:book).group_by(&:status)
  end
end
