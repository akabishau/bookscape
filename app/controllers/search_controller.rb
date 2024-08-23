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
    @books_data.each do |book|
      book[:status] = UserBookService.reading_status(current_user, book[:google_id])
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
