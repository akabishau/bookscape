class UserBooksController < ApplicationController
  def index
    # TODO: review possible alt approach of using user.books
    # TODO: sort/filter books - check SnippetsLab for previous implementation
    @user_books = current_user.user_books.includes(:book, :review)
  end

  def create
    service = BookStatusService.new(current_user, user_book_params[:google_id], user_book_params[:status])

    if service.call
      redirect_to(user_books_path, notice: "Book added to your library with the selected status.")
    else
      redirect_back(fallback_location: search_path, alert: "Failed to add the book to your library.")
    end
  end

  def show
    @user_book = current_user.user_books.find(params[:id])
  end

  def update
    service = BookStatusService.new(current_user, params[:user_book][:google_id], params[:user_book][:status])
    service.call
    # TODO: should stay on the same page after updating the status
    redirect_to(user_books_path, notice: "Reading status updated successfully.")
  end

  private

  def user_book_params
    params.require(:user_book).permit(:google_id, :status)
  end
end
