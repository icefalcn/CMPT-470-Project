class WatchlistController < ApplicationController
  def index
    @watchlist = Watchlists.select("*").joins("INNER JOIN movies on watchlists.movieid = movies.movieid")
  end
end
