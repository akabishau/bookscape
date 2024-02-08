require "httparty"

class SearchController < ApplicationController
  # GET /search - display the search form
  def index
    # :query is the name of the input field in the form
    return unless params[:query].present?

    response = GoogleBooksApi.new.search_books(params[:query])
    puts response.body
    if response.success?
      begin
        json_data = JSON.parse(response.body)
        books = GoogleBooksParser.parse(json_data)
        @books = books.map { |book| SearchBookPresenter.new(book, current_user.books) }
      rescue JSON::ParserError
        flash[:alert] = "There was an error parsing the search results. Please try again."
      end
    else
      flash[:alert] = "There was an error with the search. Please try again."
    end
  end
end
