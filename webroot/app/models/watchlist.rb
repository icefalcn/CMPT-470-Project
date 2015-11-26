class Watchlist < ActiveRecord::Base
	has_many :movies
	belongs_to :customers
end
