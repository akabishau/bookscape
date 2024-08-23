require "httparty"

class SearchController < ApplicationController
  # GET /search - display the search form
  def index
    # :query is the name of the input field in the form
    return if params[:query].blank?

    # TODO: handle empty search query - empty state view
    # TODO: possibly make search available to non-logged in users
    # TODO: possibly add pagination, like more button

    @books_data = search_books(params[:query])
    # @books_data.each do |book|
    #   book[:status] = UserBookService.reading_status(current_user, book[:google_id])
    # end
    @books = @books_data.map do |book_data|
      # Check if the book already exists in the database
      Book.find_or_initialize_by(google_id: book_data[:google_id]) do |book|
        # If new, initialize it with the parsed data
        book.title = book_data[:title]
        book.subtitle = book_data[:subtitle]
        book.authors = book_data[:authors]
        book.main_category = book_data[:main_category]
        book.description = book_data[:description]
        book.short_description = book_data[:short_description]
        book.cover_url_thumbnail = book_data[:cover_url_thumbnail]
        book.publisher = book_data[:publisher]
        book.published_date = book_data[:published_date]
        book.page_count = book_data[:page_count]
        book.isbn10 = book_data[:edition_details][:isbn10]
        book.isbn13 = book_data[:edition_details][:isbn13]
        book.print_type = book_data[:print_type]
        book.self_link = book_data[:self_link]
        book.categories = book_data[:categories]
      end
    end
  end

  private

  # TODO: split this method into smaller ones
  # TODO: review error handling
  def search_books(query)
    response = GoogleBooksApi.new.search_books(params[:query])

    if response.success?
      begin
        json_data = JSON.parse(response.body)
        GoogleBooksParser.parse(json_data, current_user)
      rescue StandardError => e
        Rails.logger.error("Failed to parse books data: #{e.message}")
        redirect_to(:search, alert: "There was a problem with your search. Please try again later.")
      end

    else
      Rails.logger.error("Failed to fetch books from Google Books API: #{response.code} - #{response.body}")
      redirect_to(:search, alert: "There was a problem with your search. Please try again later.")
    end
  end
end
