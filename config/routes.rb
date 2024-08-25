Rails.application.routes.draw do
  get "home/index"
  devise_for :users
  root to: "home#index"

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
  get "user_books", to: "user_books#index"
end
