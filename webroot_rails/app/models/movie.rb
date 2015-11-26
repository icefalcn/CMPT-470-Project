class Movie < ActiveRecord::Base
	has_many :parts 
	has_many :actors, through: :parts #trailer or gallery 


	def self.search(query)
	    # where(:title, query) -> This would return an exact match of the query
	    where("title like ?", "%#{query}%") 
  	end



end

# def self.search(search)
#   if search
#     find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
#   else
#     find(:all)
#   end
# end