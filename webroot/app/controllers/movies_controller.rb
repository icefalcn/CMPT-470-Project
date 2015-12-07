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
    @number = @movie.rating 
  end
  
  def edit
    @movie = Movies.find(params[:movieID])
  end
  
  def update
    @movie = Movies.find(params[:movieID])
    if params[:vote].present? # if params.has_key?(title) #update vote attr
        respond_to do |format|
          format.html 
          format.xml  { render :xml => '' }
          format.json { render :json => '' }
        end 
        @movie.increment!(:rating,params[:vote].to_i)
    else #update other attr
        if @movie.update(movie_params)
          redirect_to @m
        else
          render 'edit'
        end
    end

  end
  
  private
  def movie_params
    params.requires(:movie).permit(:title, :producer, :genre, :year, :rating, :urlink, :synopsys, :urlandscape)
  end
end
