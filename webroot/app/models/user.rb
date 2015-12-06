class User < ActiveRecord::Base
	validates_presence_of :username, :email, :password
	has_one :watchlists
	has_many :movies, :through => :watchlists
end
