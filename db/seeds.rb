# drop db and run db:prepare to run this seed file
if Rails.env.development?

  user = User.create(email: "user1@email.com", password: "password")

  books = (1..100).map do |i|
    Book.find_or_create_by!(title: "Book #{i}", google_id: "google id #{i}")
  end

  statuses = UserBook.statuses.except("to_add").keys

  # Associate all books with user1 using different statuses
  books.each_with_index do |book, index|
    status = statuses[index % statuses.size] # Cycle through the statuses
    UserBook.find_or_create_by!(user: user, book: book, status: status)
  end
end
