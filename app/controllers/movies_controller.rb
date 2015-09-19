class MoviesController < ApplicationController
  before_action :find_movie, only: [:edit, :update, :destroy, :upvote, :downvote]
  before_action :require_user, except: [:index, :show]

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.create(movie_params)
    @movie.creator = current_user
    if @movie.save
      flash[:success] = "You have successfully added the movie '#{@movie.title}'"
      redirect_to home_path
    else
      flash[:error] = "You cannot add this video. Please check the errors."
      render :new
    end
  end

  def show
    @movie = Movie.where(id: params[:id]).first
    @reviews = Review.where(movie_id: @movie.id).order("created_at DESC")
    
    if @reviews.blank?
      @avg_rating = 0
    else
      @avg_rating = @reviews.average(:rating).round(2)
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      flash[:success] = "edit successfully!"
      redirect_to movies_path
    else
      flash[:error] = "There are something wrong with your update."
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path
  end

  def search
    if params[:search].present?
      @movies = Movie.search(params[:search])
    else
      @movies = Movie.all
    end
  end

  def upvote
    @movie.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @movie.downvote_by current_user
    redirect_to :back
  end

  private

  def find_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :year, :plot, :image)
  end
end