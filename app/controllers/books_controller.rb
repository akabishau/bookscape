class BooksController < ApplicationController
  def create
    cache_key = "books_search_#{current_user.id}"
    search_books = Rails.cache.read(cache_key)
    Rails.logger.info("Reading from cache with key: #{cache_key}")
    Rails.logger.info("Data: #{search_books}")
    if search_books
      book_info = search_books.find { |book| book[:google_id] == book_params[:google_id] }

      book = Book.find_by(google_id: book_params[:google_id])
      if book.nil?
        puts "BOOK INFO: #{book_info.inspect} - New Book! Creating..."
        book = Book.create(google_id: book_info[:google_id], title: book_info[:title], authors: book_info[:authors])
        puts "BOOK ERRORS: #{book.errors.full_messages}" if book.errors.any?
      end
      UserBook.create(user: current_user, book:, status: book_params[:status])
    else
      redirect_to :search, alert: "Please search for a book before adding it to your library."
    end
  end

  def index
    @books_with_status = UserBookService.all_user_books_with_status(current_user)
  end

  private

  def book_params
    params.require(:book).permit(:google_id, :status)
  end
end
