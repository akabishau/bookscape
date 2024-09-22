class UserBookService
  def self.reading_status(user, google_id)
    user_book = find_by_google_id(user, google_id)
    user_book&.status
  end

  # def self.add_or_update_status(user, book_params, book_info)
  #   Rails.logger.info("Adding or updating status for user: #{user.id}, book: #{book_params[:google_id]}")
  #   user_book = find_by_google_id(user, book_params[:google_id])

  #   if user_book
  #     user_book.update(status: book_params[:status])
  #     Rails.logger.info("Updated status to: #{book_params[:status]}")
  #   else
  #     book = BookService.find_or_create_book(book_info)
  #     user_book = UserBook.create(user:, book:, status: book_params[:status])
  #     if user_book.persisted?
  #       Rails.logger.info("Added new book with status: #{book_params[:status]}")
  #     else
  #       Rails.logger.error("Failed to create UserBook: #{user_book.errors.full_messages.join(", ")}")
  #     end
  #   end
  # end

  def self.remove_book(user, google_id)
    book = Book.find_by(google_id:)
    user.user_books.find_by(book:)&.destroy
    # &. is safe navigation operator
  end

  # def self.find_user_books_details(user)
  #   user.user_books.includes(:book).map do |user_book|
  #     book = BookService.find_book_details(user_book.book.id)
  #     book[:status] = user_book.status
  #     review = user_book.review
  #     book[:review] = review if review
  #     book
  #   end
  # end

  def self.group_user_books_by_status(user)
    books = find_user_books_details(user)
    books.group_by { |book| book[:status] }
  end

  def self.find_by_google_id(user, google_id)
    Rails.logger.info("Finding user book with GoogleID: #{google_id}")
    book = Book.find_by(google_id:)
    user.user_books.find_by(book:)
  end

  private_class_method :find_by_google_id
end
