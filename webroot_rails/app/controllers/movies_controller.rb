class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    @movie = Movie.new 
  end

  def search
  	if params[:search]
      @movies = Movie.search(params[:search]).order("title DESC")
    else
      @movies = Movie.all
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
    @movie.update_attribute(:title, "there")
    # respond_with @movie
      if @movie.update(movie_params)
        @movie.update_attribute(:title, "if")
        redirect_to @movie
      else
        @movie.update_attribute(:title, "else")
        render 'edit'
      end
  end

  def upvote
    @movie = Movie.find(params[:id])
    # @movie.increment!(:rating,1)
    @movie.update_attribute(:title, "up")
    # redirect_to '/index' 
    # render '/index'
  end

  def downvote
    @movie = Movie.find(params[:id])
    # @movie.increment!(:rating,-1)
    @movie.update_attribute(:title, "down")
  end

  # helper_method :downvote
  # helper_method :upvote
  # helper :all

  private 
  def movie_params 
    params.require(:movie).permit(:title,:image,:release_year,:plot) 
  end




end
