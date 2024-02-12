class BookService
  def self.find_or_create_book(book_params)
    book = Book.find_by(google_id: book_params[:google_id])
    Rails.logger.info("BOOK found with GoogleID #{book_params[:google_id]} and title: #{book.title}") unless book.nil?
    return book unless book.nil?

    Rails.logger.info("NO BOOK found with GoogleID #{book_params[:google_id]}. Creating new book... with params: #{book_params}")
    book = Book.create(
      google_id: book_params[:google_id],
      title: book_params[:title],
      authors: book_params[:authors],
      main_category: book_params[:main_category],
      description: book_params[:description],
      short_description: book_params[:short_description],
      cover_url_thumbnail: book_params[:cover_url_thumbnail],
      print_type: book_params[:print_type],
      subtitle: book_params[:subtitle],
      publisher: book_params[:edition_details][:publisher],
      published_date: book_params[:edition_details][:published_date],
      isbn_13: book_params[:edition_details][:isbn13],
      isbn_10: book_params[:edition_details][:isbn10],
      page_count: book_params[:edition_details][:page_count],
      self_link: book_params[:self_link],
      categories: book_params[:categories]
      # TODO: consider find_or_initialize_by + tap + save to keep information up to date assuming that latest info is the best
    )
    Rails.logger.info("BOOK ERRORS: #{book.errors.full_messages}") if book.errors.any?
    book
  end
end

# TODO: consider find_or_initialize_by + tap + save to keep information up to date assuming that latest info is the best
