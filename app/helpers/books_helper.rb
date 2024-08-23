module BooksHelper
  def reading_status_options
    UserBook.statuses.keys.map { |status| [status.titleize, status] }
  end

  # def current_reading_status(google_id)
  #   UserBookService.reading_status(current_user, google_id)
  # end

  def current_reading_status(book)
    book.reading_status_for(current_user)
  end
end
