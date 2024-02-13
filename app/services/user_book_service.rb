class UserBookService
  def self.reading_status(user, google_id)
    user_book = find_by_google_id(user, google_id)
    user_book&.status
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

  def self.remove_book(user, google_id)
    book = Book.find_by(google_id:)
    user.user_books.find_by(book:)&.destroy
    # &. is safe navigation operator
  end

  # TODO: books page currently shows all books with their status - review
  def self.all_user_books_with_status(user)
    # TODO: refactor book info to the book service
    user.user_books.includes(:book).map do |user_book|
      Rails.logger.debug "Book ID: #{user_book.book.id}, Cover URL: #{user_book.book.cover_url_thumbnail}"
      book = {
        id: user_book.book.id,
        title: user_book.book.title,
        subtitle: user_book.book.subtitle,
        authors: user_book.book.authors,
        status: user_book.status,
        main_category: user_book.book.main_category,
        categories: user_book.book.categories,
        description: user_book.book.description,
        short_description: user_book.book.short_description,
        cover_url_thumbnail: user_book.book.cover_url_thumbnail,
        print_type: user_book.book.print_type,
        edition_details: {
          publisher: user_book.book.publisher,
          published_date: user_book.book.published_date,
          isbn13: user_book.book.isbn_13,
          isbn10: user_book.book.isbn_10,
          page_count: user_book.book.page_count
        }
      }
      Rails.logger.info(book)
      book
    end
  end

  def self.group_user_books_by_status(user)
    books = all_user_books_with_status(user)
    books.group_by { |book| book[:status] }
  end

  def self.find_by_google_id(user, google_id)
    Rails.logger.info("Finding user book with GoogleID: #{google_id}")
    book = Book.find_by(google_id:)
    user.user_books.find_by(book:)
  end

  def self.user_has_book?(user, book)
    user.user_books.exists?(book:)
  end

  private_class_method :find_by_google_id, :user_has_book?
end
