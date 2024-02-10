class UserBookService
  # error handling is not implemented
  def self.add_book_to_user(user, book_params, status)
    book = BookService.find_or_create_book(book_params)
    UserBook.create(user:, book:, status:)
  end

  def self.add_or_update_status(user, book_params, book_info)
    Rails.logger.info("Adding or updating status for user: #{user.id}, book: #{book_params[:google_id]}")
    user_book = find_by_google_id(user, book_params[:google_id])

    if user_book
      user_book.update(status: book_params[:status])
      Rails.logger.info("Updated status to: #{book_params[:status]}")
    else
      book = BookService.find_or_create_book(book_info)
      user_book = UserBook.create(user:, book:, status: book_params[:status])
      if user_book.persisted?
        Rails.logger.info("Added new book with status: #{book_params[:status]}")
      else
        Rails.logger.error("Failed to create UserBook: #{user_book.errors.full_messages.join(', ')}")
      end
    end
  end

  def update_status(user, book, status)
    user.user_books.find_by(book:).update(status:)
  end

  def self.remove_book(user, google_id)
    book = Book.find_by(google_id:)
    user.user_books.find_by(book:)&.destroy
    # &. is safe navigation operator
  end

  # books page currently shows all books with their status
  # review - not complete
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

  private

  def self.find_by_google_id(user, google_id)
    Rails.logger.info("Finding user book with GoogleID: #{google_id}")
    book = Book.find_by(google_id:)
    user.user_books.find_by(book:)
  end

  # does user have a book?
  def user_has_book?(user, book)
    user.user_books.exists?(book:)
  end
end
