class MainController < ApplicationController
  def index
    @action = Movies.where("genre like ?", "%Action%").order("rating").first(3)
    @comedy = Movies.where("genre like ?", "%Comedy%").order("rating").first(3)
    @animation = Movies.where("genre like ?", "%Animation%").order("rating").first(3)
    @romance = Movies.where("genre like ?", "%Romance%").order("rating").first(3)
  end
end
