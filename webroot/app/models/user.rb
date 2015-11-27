class User < ActiveRecord::Base
	has_one :watchlist
	has_many :movies, :through => :watchlist
end
