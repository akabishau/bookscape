class ReviewsController < ApplicationController
  before_action :set_book
  before_action :set_user_book
  before_action :set_review, only: [:edit, :update]

  # view for new review
  def new
    @review = @user_book.build_review
  end

  def create
    @review = @user_book.build_review(review_params)

    if @review.save
      redirect_to(book_path(@book), notice: "Review added successfully.")
    else
      render(:new)
    end
  end

  # view for editing review
  def edit
    @review
  end

  def update
    @review = @user_book.review

    if @review.update(review_params)
      redirect_to(book_path(@book), notice: "Review updated successfully.")
    else
      render(:edit)
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_user_book
    @user_book = UserBook.find_by(user: current_user, book: @book)
  end

  def set_review
    @review = @user_book&.review
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
