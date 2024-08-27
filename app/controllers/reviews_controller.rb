class ReviewsController < ApplicationController
  before_action :set_user_book
  before_action :set_review, only: [:edit, :update]

  def new
    # association helper method, available user_book has_one review
    @review = @user_book.build_review # Review.new(user_book: @user_book)
  end

  def create
    @review = @user_book.build_review(review_params)

    if @review.save
      redirect_to(user_books_path, notice: "Review added successfully.")
    else
      render(:new)
    end
  end

  def edit
    # @review will be used in the form_for helper
  end

  def update
    if @review.update(review_params)
      redirect_to(user_books_path, notice: "Review updated successfully.")
    else
      render(:edit)
    end
  end

  private

  def set_user_book
    @user_book = UserBook.find(params[:user_book_id])
  end

  def set_review
    @review = @user_book.review
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
