class BookStatusService
  def initialize(user, google_id, status)
    @user = user
    @google_id = google_id
    @status = status
  end

  def call
    # byebug
    book = find_or_create_book
    if book.present?
      user_book = find_or_initialize_user_book(book)
      update_user_book_status(user_book)
    end
  end

  private

  def find_or_create_book
    book = Book.find_by(google_id: @google_id)
    return book if book.present?

    # Make an API call to get the book details if not found in the database
    book_data = fetch_book_details_from_api(@google_id)
    return unless book_data

    book = Book.new(book_data)
    if book.save
      book
    else
      Rails.logger.error("Failed to save book: #{book.errors.full_messages.join(", ")}")
      nil
    end
  end

  def fetch_book_details_from_api(google_id)
    # Implement your API call to fetch book details here
    response = GoogleBooksApi.new.get_book_details(google_id)
    return unless response.success?

    # Parse the JSON response body into a Ruby hash
    json_data = JSON.parse(response.body)

    GoogleBooksParser.parse_single_book(json_data)
  end

  def find_or_initialize_user_book(book)
    UserBook.find_or_initialize_by(user: @user, book: book)
  end

  def update_user_book_status(user_book)
    user_book.status = @status

    if user_book.save
      Rails.logger.info("UserBook status updated successfully.")
    else
      Rails.logger.error("Failed to save UserBook: #{user_book.errors.full_messages.join(", ")}")
    end
  end
end
