class WatchlistController < ApplicationController
  def index
    @watchlist = Watchlist.select("*")
  end
end
