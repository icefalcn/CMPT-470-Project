class WatchlistController < ApplicationController
  def index
    @watchlist = Watchlist.select("*")
  end
  def remove
  	@remove = Watchlist.delete(params[:movieid])
  end
end
