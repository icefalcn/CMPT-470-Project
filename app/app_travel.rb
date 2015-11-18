###request/response cycle and create a controller, a route, and a view.
Rails.application.routes.draw do
	get '/tags' => 'tags#index'
	get '/tags/:id' => 'tags#show', as: :tag   #<%= link_to "Learn more", tag_path(t) %>
	get '/destinations/:id' => 'destinations#show', as: :destination # <%= link_to "See more", destination_path(d) %>
	get '/destinations/:id/edit' => 'destinations#edit', as: :edit_destination 
	patch '/destinations/:id' => 'destinations#update'
end

#model not here

# Tags Controller
class TagsController < ApplicationController
  #########################tag index######################################
	def index
		@tags = Tag.all
	end
#---------------------------------------------------------------
<div class="cards row">
      <% @tags.each do |t| %>
      <div class="card col-xs-4">
        <%= image_tag t.image %>
        <h2><%= t.title %></h2>
        <%= link_to "Learn more", tag_path(t) %>
      </div>
      <% end %>
    </div>
#########################tag show######################################
get '/tags/:id' => 'tags#show', as: :tag
When a user visits http://localhost:8000/tags/1, 
the route get '/tags/:id' => 'tags#show' sends this request 
to the Tags controller's show action with {id: 1} in params.

	def show 
  	@tag = Tag.find(params[:id])    #get '/tags/:id' => 'tags#show', as: :tag   #<%= link_to "Learn more", tag_path(t) %>
  	@destinations = @tag.destinations 
	end
  ######-----------------------------tag show  dest
    <div class="cards row">
      <% @destinations.each do |d| %>
      <div class="card col-xs-4">
        <%= image_tag d.image %>
        <h2><%= d.name %></h2>
        <p><%= d.description %></p>
        <%= link_to "See more", destination_path(d) %>
      </div>
      <% end %>
    </div>
#######################################################################
#######################################################################
# Destinations Controller
class DestinationsController < ApplicationController

	def show
    @destination = Destination.find(params[:id])
  end
  #####------------------------------dest show  one
<div class="col-xs-12">
        <%= image_tag @destination.image %>
        <h2><%= @destination.name %></h2>
        <p><%= @destination.description %></p>
        <%= link_to "Edit", edit_destination_path(@destination) %>
###get '/destinations/:id/edit' => 'destinations#edit', as: :edit_destination 
      </div>
##################################################################
  def edit 
  	@destination = Destination.find(params[:id]) 
	end
	####------------------------------dest edit
  <%= image_tag @destination.image %>

    <%= form_for(@destination) do |f| %>
      <%= f.text_field :name %>
      <%= f.text_field :description %>
      <%= f.submit "anytext_for_update_btn", :class => "btn" %>   #############################
    <% end %> 
################################################################################################
	def update
    @destination = Destination.find(params[:id])
      if @destination.update(destination_params)
        redirect_to @destination
      else
        render 'edit'
      end
  end

	private 
  	def destination_params 
    	params.require(:destination).permit(:name, :description) 
  	end
end
#########################################################


# db

class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :title
      t.string :image
      t.timestamps
    end
  end
end

class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.string :name
      t.string :image
      t.string :description
      t.references :tag
      t.timestamps
    end
  end
end