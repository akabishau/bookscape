class UserBookService
  # # error handling is not implemented
  # def self.add_book_to_userr(user, book_params, status)
  #   # new_book = BookService.find_or_create_book(book_params)
  #   # puts "New book: #{new_book.inspect}"
  #   # user_book = user.user_books.find_or_initialize_by(user:, book: new_book)
  #   # user_book.status = status
  #   # return unless user_book.save

  #   # user_book
  #   book = Book.find_by(google_id: book_params[:google_id]) || Book.create(book_params)
  #   UserBook.create(user:, book:, status:)
  # end

  # error handling is not implemented
  def self.add_book_to_user(user, book, status)
    new_book = BookService.find_or_create_book(book)
    UserBook.create(user:, book: new_book, status:)
  end

  def self.all_user_books_with_status(user)
    user.user_books.includes(:book).map do |user_book|
      {
        id: user_book.book.id,
        title: user_book.book.title,
        authors: user_book.book.authors,
        status: user_book.status
      }
    end
  end
end
