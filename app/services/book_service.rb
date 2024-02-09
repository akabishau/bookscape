class BookService
  def self.find_or_create_bookk(book_params)
    Book.find_or_create_by(google_id: book_params[:google_id]) do |book|
      book.title = book_params[:title]
      book.authors = book_params[:authors]
    end
  end

  def self.find_or_create_book(book)
    Book.find_or_create_by(google_id: book[:google_id]) do |new_book|
      new_book.title = book[:title]
      new_book.authors = book[:authors]
    end
  end
end

# TODO: consider find_or_initialize_by + save to keep information up to date assuming that latest info is the best
