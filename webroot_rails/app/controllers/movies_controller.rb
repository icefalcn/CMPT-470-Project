class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    @movie = Movie.new 
  end

  def search
  	if params[:search]
      @movies = Movie.search(params[:search]).order("title DESC")
    # else
    #   @movies = Movie.all
    end
   end
 
  def show
    @movie = Movie.find(params[:id])
    @actors = @movie.actors
  end
  
  def create 
	  @movie = Movie.new(movie_params) 
	  if @movie.save 
	    redirect_to '/index' 
	  else 
	    render '/index' 
	  end 
  end
  
  def edit 
  	@movie = Movie.find(params[:id])  #find by id then display the single moive
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
    params.require(:movie).permit(:title,:image,:release_year,:plot) 
  end



end
