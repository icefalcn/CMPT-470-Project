class Movies < ActiveRecord::Base
	has_many :watchlist
	has_many :users, :through => :watchlist
	def self.search(query)
		where("title like ?", "%#{query}%")
	end
end
