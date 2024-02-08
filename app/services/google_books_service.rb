class GoogleBooksService
  include HTTParty

  # class method from HTTParty to set the base URI
  base_uri "https://www.googleapis.com/books/v1"

  def initialize(query)
    # @options is a hash with a key of :query (httparty) and a value of another hash
    @options = { query: { key: ENV["GOOGLE_BOOKS_API_KEY"], q: query } }
  end

  def search_books
    # self.class = GoogleBooksService
    # get is a class method from HTTParty, knows the base_uri
    self.class.get("/volumes", @options)
  end
end
