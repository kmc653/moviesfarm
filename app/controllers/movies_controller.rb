class MoviesController < ApplicationController
  before_action :require_user

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

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      flash[:success] = "edit successfully!"
      redirect_to movies_path
    else
      flash[:error] = "There are something wrong with your update."
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :year, :plot)
  end
end