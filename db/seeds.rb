user = User.find_or_create_by!(email: "test1@email.com") do |user|
  user.password = "test1@email.com"
  user.password_confirmation = "test1@email.com"
end

statuses = ["want_to_read", "reading", "read"]

15.times do |i|
  book = Book.find_or_create_by!(google_id: "google#{i + 1}") do |book|
    book.title = "Book #{i + 1}"
    book.authors = ["Author #{i + 1}"]
  end

  UserBook.find_or_create_by!(user:, book:) do |user_book|
    user_book.status = statuses.sample
  end
end
