class GoogleBooksParser
  def self.parse(json, user)
    # fetches all the user's books at once
    user_books = user.user_books.includes(:book).index_by { |ub| ub.book.google_id }

    json["items"].map do |item|
      google_id = item["id"]
      # TODO: temp fix for missing thumbnail, can be other fields - consider not include in the results invalid books
      image_links = item["volumeInfo"]["imageLinks"] || {}
      search_info = item["searchInfo"] || {}
      book_data = {
        google_id:,
        title: item["volumeInfo"]["title"],
        authors: item["volumeInfo"]["authors"] || ["Unknown"],
        main_category: item["volumeInfo"]["categories"] || [],
        description: item["volumeInfo"]["description"] || "No description available",
        short_description: search_info["textSnippet"] || "No description available",
        cover_url_thumbnail: image_links["thumbnail"] || "https://via.placeholder.com/128x196?text=No+cover"
      }

      user_book = user_books[google_id]
      book_data[:status] = user_book ? user_book.status : nil

      book_data
    end
  end
end
