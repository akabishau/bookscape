if Rails.env.development?

  User.create(email: "user1@email.com", password: "password")
  User.create(email: "user2@email.com", password: "password")


  books = []
  (1..10).each do |i|
    books << { title: "Book #{i}", google_id: "google_id_#{i}" }
  end
  Book.upsert_all(books, unique_by: :google_id)

end
