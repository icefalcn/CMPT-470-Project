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
    @movie = Movie.find(params[:movieID])
    if params[:vote].present? # if params.has_key?(title) #update vote attr
        respond_to do |format|
          format.html # show.html.erb
          format.xml  { render :xml => @movie }
          format.json { render :json => @movie }
        end 
        if params["vote"] == "1"
              #@movie.update_attribute(:title, "up voted")
              @movie.increment!(:rating,1)
        elsif params["vote"] == "-1"
              #@movie.update_attribute(:title, "down voted")
              @movie.increment!(:rating,-1)
        end
    else #update other attr
        if @movie.update(movie_params)
          redirect_to @movie
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
