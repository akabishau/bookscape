class SearchBookPresenter
  def initialize(book)
    @book = book
  end

  def title
    @book.title
  end

  def authors
    @book.authors.join(", ")
  end
end
