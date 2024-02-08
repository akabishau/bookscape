require "httparty"

class SearchController < ApplicationController
  before_action :init_service, only: :index

  # GET /search - display the search form
  def index
    # :query is the name of the input field in the form
    return unless params[:query].present?

    response = @service.search_books

    if response.success?
      @results = JSON.parse(response.body)
    else
      flash[:alert] = "There was an error with the search. Please try again."
      # error handling
    end
  end

  private

  def init_service
    @service = GoogleBooksService.new(params[:query])
  end
end
