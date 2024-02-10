# class SearchBookPresenter
#   delegate :google_id, to: :@book

#   def initialize(book, user)
#     @book = book
#     @user = user
#   end

#   def title
#     @book.title
#   end

#   def authors
#     @book.authors.join(", ")
#   end

#   def reading_status
#     # TODO: consider using a hash to avoid N+1 queries
#     # TODO: consider refactoring to global helper method
#     user_book = UserBook.find_by(user: @user, book: @book)
#     user_book&.status || "Not read"
#   end
# end
