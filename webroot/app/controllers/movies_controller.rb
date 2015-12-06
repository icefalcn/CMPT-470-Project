class MoviesController < ApplicationController
  def index
    @movies = Movies.all
    #@movie = Movie.find(params[:id])
  end
  
  def search
    if params[:search]
      @movies = Movies.search(params[:search]).order("title ASC")
    end
  end
  
  def show
    @movie = Movies.find(params[:movieID])
    @title = @movie.title
    @genre = @movie.genre
    @rating = @movie.rating
    @synopsys = @movie.synopsys   
  end
  
  def edit
    @movie = Movies.find(params[:id])
  end
  
  def update
    @movie = Movies.find(params[:id])
      if @movie.update(movie_params)
        redirect_to @movie
      else
        render 'edit'
      end
  end
  
  private
  def movie_params
    params.requires(:movie).permit(:title, :producer, :genre, :year, :rating, :urlink, :synopsys, :urlandscape)
  end
end
