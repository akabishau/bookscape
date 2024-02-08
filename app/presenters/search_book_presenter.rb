class SearchBookPresenter
  def initialize(book, user_books)
    @book = book
    @user_books = user_books
  end

  def title
    @book.title
  end

  def authors
    @book.authors.join(", ")
  end

  def reading_status
    # TODO: consider using a hash to avoid N+1 queries
    # TODO: consider refactoring to global helper method
    book = @user_books.find { |user_book| user_book.google_id == @book.google_id }
    book&.status || "Not read"
  end
end
