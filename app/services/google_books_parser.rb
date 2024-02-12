class GoogleBooksParser
  def self.parse(json, user)
    # fetches all the user's books at once
    user_books = user.user_books.includes(:book).index_by { |ub| ub.book.google_id }

    json["items"].map do |item|
      google_id = item["id"]
      # TODO: temp fix for missing thumbnail, can be other fields - consider not include in the results invalid books
      # image_links = item["volumeInfo"]["imageLinks"] || {}
      # search_info = item["searchInfo"] || {}
      book_data = {
        google_id: item["id"],
        self_link: item["selfLink"],
        title: item.dig("volumeInfo", "title"),
        subtitle: item.dig("volumeInfo", "subtitle"),
        authors: item.dig("volumeInfo", "authors") || ["Unknown"],
        main_category: item.dig("volumeInfo", "categories") || [],
        categories: item.dig("volumeInfo", "categories"),
        description: item.dig("volumeInfo", "description") || "No description available",
        short_description: item.dig("searchInfo", "textSnippet") || "No description available",
        cover_url_thumbnail: item.dig("volumeInfo", "imageLinks", "thumbnail") || "https://via.placeholder.com/128x196?text=No+cover",
        print_type: item.dig("volumeInfo", "printType"),
        edition_details: {
          publisher: item.dig("volumeInfo", "publisher"),
          published_date: item.dig("volumeInfo", "publishedDate"),
          isbn13: item.dig("volumeInfo", "industryIdentifiers").find { |id| id["type"] == "ISBN_13" }["identifier"],
          isbn10: item.dig("volumeInfo", "industryIdentifiers").find { |id| id["type"] == "ISBN_10" }["identifier"],
          page_count: item.dig("volumeInfo", "pageCount")
        }
      }

      user_book = user_books[google_id]
      book_data[:status] = user_book ? user_book.status : nil

      book_data
    end
  end
end
