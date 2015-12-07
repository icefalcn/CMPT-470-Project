class WatchlistController < ApplicationController
  def index
    @watchlist = Watchlists.select("*").joins("INNER JOIN movies on watchlists.movieid = movies.movieid")
  end
  def delete
  	# Watchlists.where(:movieid => params[:m_id]).destroy_all
  	  	Watchlists.where("movieid" => params[:m_id] ).destroy_all

  	respond_to do |format|
  			format.html
  			format.xml {render :xml => ''}
  			format.json {render :json => ''}
  		end
  end



private
  def watchlists_params
    params.require(:watchlists).permit(:uid, :movieid)
  end



end
