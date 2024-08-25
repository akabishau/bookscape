class UserBooksController < ApplicationController
  def index
    # TODO: review possible alt approach of using user.books
    @user_books = current_user.user_books.includes(:book, :review)
  end
end
