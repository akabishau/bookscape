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
        @books_data = GoogleBooksParser.parse(json_data, current_user)
        cache_key = "books_search_#{current_user.id}"
        Rails.cache.write(cache_key, @books_data, expires_in: 1.hour)
        Rails.logger.info("Writing to cache with key: #{cache_key}")
        Rails.logger.info("Data: #{@books_data}")
      rescue JSON::ParserError
        flash[:alert] = "There was an error parsing the search results. Please try again."
      end
    else
      flash[:alert] = "There was an error with the search. Please try again."
    end
  end
end
