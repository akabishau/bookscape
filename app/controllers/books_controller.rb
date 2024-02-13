class BooksController < ApplicationController
  # TODO: think of better name, since it's not really book creation but adding book to user's reading collection
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
    books = UserBookService.find_user_books_details(current_user)

    if params[:statuses].present?
      books = books.select do |book|
        params[:statuses].include?(book[:status])
      end
    end

    sort_order = params[:sort] || "title_asc"
    books = sort_books(books, sort_order)
    @books_with_status = books
  end

  def show
    # TODO: book helper method book hash
    @book = Book.find(params[:id])
  end

  private

  def book_params
    params.require(:book).permit(:google_id, :status)
  end

  def handle_reading_status_change(book_params, book_info)
    if UserBook.statuses.keys.include?(book_params[:status])
      UserBookService.add_or_update_status(current_user, book_params, book_info)
    else
      UserBookService.remove_book(current_user, book_params[:google_id])
    end
  end

  def sort_books(books, sort_order)
    case sort_order
    when "title_asc"
      books.sort_by { |book| book[:title].downcase }
    when "title_desc"
      books.sort_by { |book| book[:title].downcase }.reverse
    else
      books
    end
  end
end
