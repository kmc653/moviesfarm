class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.create(movie_params)
    if @movie.save
      flash[:success] = "You have successfully added the movie '#{@movie.title}'"
      redirect_to home_path
    else
      flash[:error] = "You cannot add this video. Please check the errors."
      render :new
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :year, :plot)
  end
end