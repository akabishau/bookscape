class BookService
  # book_params is a hash coming from Cached Google Books API response
  def self.find_or_create_book(book_params)
    book = Book.find_by(google_id: book_params[:google_id])
    Rails.logger.info("BOOK found with GoogleID #{book_params[:google_id]} and title: #{book.title}") unless book.nil?
    return book unless book.nil?

    Rails.logger.info("NO BOOK found. Creating NEW with GoogleID: #{book_params[:google_id]}")
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
      isbn13: book_params[:edition_details][:isbn13],
      isbn10: book_params[:edition_details][:isbn10],
      page_count: book_params[:edition_details][:page_count],
      self_link: book_params[:self_link],
      categories: book_params[:categories]
      # TODO: consider find_or_initialize_by + tap + save to keep info up to date assuming that latest info is the best
    )
    Rails.logger.info("BOOK ERRORS: #{book.errors.full_messages}") if book.errors.any?
    book
  end

  def self.find_book_details(book_id)
    book = Book.find(book_id)
    {
      id: book.id,
      google_id: book.google_id,
      title: book.title,
      subtitle: book.subtitle,
      authors: book.authors,
      main_category: book.main_category,
      categories: book.categories,
      description: book.description,
      short_description: book.short_description,
      cover_url_thumbnail: book.cover_url_thumbnail,
      print_type: book.print_type,
      edition_details: {
        publisher: book.publisher,
        published_date: book.published_date,
        isbn13: book.isbn13,
        isbn10: book.isbn10,
        page_count: book.page_count
      }
    }
  end
end
