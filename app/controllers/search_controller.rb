require "httparty"

class SearchController < ApplicationController
  # GET /search - display the search form
  def index
    # :query is the name of the input field in the form
    return if params[:query].blank?

    response = GoogleBooksApi.new.search_books(params[:query])
    if response.success?
      begin
        json_data = JSON.parse(response.body)
        @books_data = GoogleBooksParser.parse(json_data, current_user)
        CacheService.cache(current_user, CacheScenarios::BOOK_SEARCH, @books_data)
      rescue StandardError => e
        Rails.logger.error("Failed to parse books data: #{e.message}")
        redirect_to :search, alert: "There was a problem with your search. Please try again later."
      end
    else
      Rails.logger.error("Failed to fetch books from Google Books API: #{response.code} - #{response.body}")
      redirect_to :search, alert: "There was a problem with your search. Please try again later."
    end
  end
end
