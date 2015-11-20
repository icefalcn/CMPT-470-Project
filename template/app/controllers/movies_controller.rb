class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    #@movie = Movie.find(params[:id])
  end
  
  def search
    if param[:search]
      @movies = Movie.search(params[:search].order("title DESC"))
    end
  end
  
  def show
    @movie = Movie.find(params[:id])
    @title = @movie.title
    @genre = @movie.genre
    @rating = @movie.rating
    @synopsys = @movie.synopsys   
  end
  
  def edit
    @movie = Movie.find(params[:id])
  end
  
  def update
    @movie = Movie.find(params[:id])
      if @movie.update(movie_params)
        redirect_to @movie
      else
        render 'edit'
      end
  end
  
  private
  def movie_params
    params.requires(:movie).permit(:title, :producer, :genre, :year, :rating, :urlink, :synopsys)
  end
end
