require "httparty"

class SearchController < ApplicationController
  # GET /search - display the search form
  def index
    return unless params[:query].present?

    @results = perform_search(params[:query])
  end

  private

  def perform_search(query)
    base_url = "https://www.googleapis.com/books/v1/volumes"
    api_key = ENV["GOOGLE_BOOKS_API_KEY"]
    url = "#{base_url}?q=#{URI.encode_www_form_component(query)}&key=#{api_key}"
    response = HTTParty.get(url)
    JSON.parse(response.body)
  end
end
