class GoogleBooksParser
  def self.parse(json)
    json["items"].map do |item|
      # REVIEW: this approach of parsing Book objects
      book = Book.new(
        google_id: item["id"],
        title: item["volumeInfo"]["title"],
        authors: item["volumeInfo"]["authors"] || ["Unknown"]
      )

      # TODO: need to somehow check user-book association to set the button text
      # book if book.valid? # doesn't fit business logic
      book
    end.compact
  end
end
