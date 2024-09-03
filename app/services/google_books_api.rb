class GoogleBooksApi
  include HTTParty

  # class method from HTTParty to set the base URI
  base_uri "https://www.googleapis.com/books/v1"

  def initialize
    # "query" is HTTParty way of passing query parameters
    @options = {
      query:
            {
              key: ENV["GOOGLE_BOOKS_API_KEY"],
              langRestrict: "en", # restrict to English language
              maxResults: 30,
            },
    }
  end

  def search_books(search_query)
    # :q is google api query parameter
    @options[:query][:q] = search_query
    # self.class = GoogleBooksService
    # get is a class method from HTTParty, knows the base_uri
    self.class.get("/volumes", @options)
  end

  def get_book_details(google_id)
    self.class.get("/volumes/#{google_id}", @options)
  end
end
