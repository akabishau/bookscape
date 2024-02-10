class GoogleBooksParser
  def self.parse(json, user)
    # fetches all the user's books at once
    user_books = user.user_books.includes(:book).index_by { |ub| ub.book.google_id }

    json["items"].map do |item|
      google_id = item["id"]
      book_data = {
        google_id:,
        title: item["volumeInfo"]["title"],
        authors: item["volumeInfo"]["authors"] || ["Unknown"]
      }

      user_book = user_books[google_id]
      book_data[:status] = user_book ? user_book.status : nil

      book_data
    end
  end
end
