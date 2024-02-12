class BooksController < ApplicationController
  def create
    search_books = CacheService.fetch(current_user, CacheScenarios::BOOK_SEARCH)

    if search_books
      book_info = search_books.find { |book| book[:google_id] == book_params[:google_id] }

      handle_reading_status_change(book_params, book_info)
    else
      redirect_to :search
      Rails.logger.error("Failed to find book in cache: #{book_params[:google_id]}")
    end
  end

  def index
    @books_with_status = UserBookService.all_user_books_with_status(current_user)
  end

  def show
    @book = Book.find(params[:id])
  end

  private

  def book_params
    params.require(:book).permit(:google_id, :status)
  end

  def handle_reading_status_change(book_params, book_info)
    # case book_params[:status]
    if UserBook.statuses.keys.include?(book_params[:status])
      UserBookService.add_or_update_status(current_user, book_params, book_info)
    else
      UserBookService.remove_book(current_user, book_params[:google_id])
    end
  end
end
