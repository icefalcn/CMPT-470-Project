class WatchlistController < ApplicationController
  def index
    @watchlist = Watchlists.select("*")
  end
  def remove
  	#@remove = Watchlists.delete(params[:movieid])
  end
end
