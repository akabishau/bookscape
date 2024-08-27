class UserBooksController < ApplicationController
  def index
    # TODO: review possible alt approach of using user.books
    @user_books = current_user.user_books.includes(:book, :review)
  end

  def update
    @user_book = UserBook.find(params[:id])
    if @user_book.update(user_book_params)
      flash[:notice] = "Reading status updated successfully."
    else
      flash[:alert] = "Failed to update reading status."
    end

    # TODO: refactor using turbo stream
    redirect_to(user_books_path) # redirect helps to prevent form resubmission
  end

  private

  def user_book_params
    params.require(:user_book).permit(:status)
  end
end
