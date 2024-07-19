Rails.application.routes.draw do
  get "home/index"
  devise_for :users
  root to: "home#index"

  resources :books, only: [:create, :index, :show]

  get "search", to: "search#index"
end
a
