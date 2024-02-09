require "httparty"

class SearchController < ApplicationController
  # GET /search - display the search form
  def index
    # :query is the name of the input field in the form
    return unless params[:query].present?

    response = GoogleBooksApi.new.search_books(params[:query])
    if response.success?
      begin
        json_data = JSON.parse(response.body)
        books = GoogleBooksParser.parse(json_data)
        # @books = books.map { |book| SearchBookPresenter.new(book, current_user) }
        @books = books.map do |book|
          book_hash = book.attributes.symbolize_keys
          existing_book = Book.find_by(google_id: book.google_id)
          status = nil
          if existing_book
            user_book = UserBook.find_by(user: current_user, book: existing_book)
            status = user_book&.status
          end
          puts "BOOK HASH: #{book_hash.inspect}"
          { book: book_hash, status: }
        end
      rescue JSON::ParserError
        flash[:alert] = "There was an error parsing the search results. Please try again."
      end
    else
      flash[:alert] = "There was an error with the search. Please try again."
    end
  end
end
