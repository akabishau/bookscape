class BooksController < ApplicationController
  def create
    book = Book.find_by(google_id: book_params[:google_id])
    if book.nil?
      book = Book.create(book_params.except(:status))
      puts "BOOK ERRORS: #{book.errors.full_messages}" if book.errors.any?
    end
    puts "BOOK: #{book.inspect}"
    UserBook.create(user: current_user, book:, status: user_book_params[:status])

    # Handle validation errors here, e.g.:
    # raise "Failed to create book: #{book.errors.full_messages.join(', ')}"
  end

  def index
    @books_with_status = UserBookService.all_user_books_with_status(current_user)
  end

  private

  def book_params
    params.permit(:title, :google_id, :status, authors: [])
  end

  def user_book_params
    params.permit(:status)
  end
end
