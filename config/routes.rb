Rails.application.routes.draw do
  get "home/index"
  devise_for :users
  root to: "home#index"

  # to handle post requests for reading status update
  # resources :user_books, only: [:create, :update, :destroy]

  # Custom route for updating the reading status of a UserBook
  post "user_books/update_status", to: "user_books#update_status", as: :user_books_update_status

  resources :books, only: [:create, :index, :show] do
    resource :review, only: [:new, :create, :edit, :update]
    # Routes Generated:
    # •	new_book_review_path(book) → /books/:book_id/review/new
    # •	create_book_review_path(book) → /books/:book_id/review
    # •	edit_book_review_path(book) → /books/:book_id/review/edit
    # •	update_book_review_path(book) → /books/:book_id/review
  end

  get "search", to: "search#index"

  # library endpoint
  # get "user_books", to: "user_books#index"

  resources :user_books, only: [:index] do
    # use single resource - user_book has only one review
    resource :review, only: [:new, :create, :edit, :update]
    # user_books/:id/review/new or edit
    # new_user_book_review_path(user_book) -> /user_books/:user_book_id/review/new
  end

  # UserBooks routes
  # get "/user_books", to: "user_books#index", as: "user_books"
  # # Review routes under UserBook
  # get "/user_books/:user_book_id/review/new", to: "reviews#new", as: "new_user_book_review"
  # post "/user_books/:user_book_id/review", to: "reviews#create", as: "user_book_reviews"
  # get "/user_books/:user_book_id/review/edit", to: "reviews#edit", as: "edit_user_book_review"
  # patch "/user_books/:user_book_id/review", to: "reviews#update"
  # put "/user_books/:user_book_id/review", to: "reviews#update"
end
