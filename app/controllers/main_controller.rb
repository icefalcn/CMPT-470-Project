class MainController < ApplicationController
	def index
		@movies = Movie.new
		#@movie = Movie.find(params[:id])

	end


	def search
		render 'main'
	end

	# def create 
	#   @message = Message.new(message_params) 
	#   if @message.save 
	#     redirect_to '/messages' 
	#   else 
	#     render 'new' 
	#   end 
	# end


	
end
