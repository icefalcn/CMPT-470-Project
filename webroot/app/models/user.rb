class User < ActiveRecord::Base
	validates_presence_of :username, :email, :password
	has_one :watchlist
	has_many :movies, :through => :watchlist
end
