# drop db and run db:prepare to run this seed file
if Rails.env.development?

  user1 = User.create(email: "user1@email.com", password: "password")
  user2 = User.create(email: "user2@email.com", password: "password")

  books = (1..10).map do |i|
    Book.find_or_create_by!(title: "Book #{i}", google_id: "google id #{i}")
  end

  statuses = UserBook.statuses.except("to_add").keys

  # Associate all books with user1 using different statuses
  books.each_with_index do |book, index|
    status = statuses[index % statuses.size] # Cycle through the statuses
    UserBook.find_or_create_by!(user: user1, book: book, status: status)
  end

  # give user2 one book
  UserBook.find_or_create_by!(user: user2, book: books.first, status: :want)

end
