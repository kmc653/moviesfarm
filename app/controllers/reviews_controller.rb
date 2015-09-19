class ReviewsController < ApplicationController
  before_action :require_user
  before_action :set_movie

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.creator = current_user
    @review.movie_id = @movie.id

    if @review.save
      redirect_to @movie
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end