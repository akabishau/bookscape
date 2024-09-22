module BooksHelper
  def reading_status_options
    UserBook.statuses.keys.map { |status| [status.titleize, status] }
  end

  def current_reading_status(book)
    book.reading_status_for(current_user)
  end
end
