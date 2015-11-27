class MainController < ApplicationController
  def index
    @movies = Movies.last(5)
  end
end
