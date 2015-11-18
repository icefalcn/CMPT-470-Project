class ContactsController < ApplicationController
	
	def index
		@contacts = Contact.all
	end

	def show
		@contact = Contact.find(params[:id])
	end
	
	def new
		@contact = Contact.new
	end

	def edit
		@contact = Contact.new(contact_params)
		if @article.save
    		redirect_to @article
		else
    		render 'new'
    	end
	end


	def create
		@contact = Contact.new(contact_params)

		@contact.save
		redirect_to @contact
	end

	private 
		def contact_params
			params.require(:contact).permit(:fname, :lname, :email, :pnum, :notes)
		end
end
