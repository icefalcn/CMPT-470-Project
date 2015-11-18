Rails.application.routes.draw do
  get '/messages' => 'messages#index'
  get '/messages/new' => 'messages#new'
  post 'messages' => 'messages#create'
end

#db
create_table :messages do |t|   
    t.text :content
    t.timestamps

class MessagesController < ApplicationController
  def index 
  @messages = Message.all 
end
  def new 
  @message = Message.new 
end
  
  def create 
  @message = Message.new(message_params) 
  if @message.save 
    redirect_to '/messages' 
  else 
    render 'new' 
  end 
end
  
  private 
  def message_params 
    params.require(:message).permit(:content) 
  end
end

# index  show all messages
<div class="messages">
  <div class="container">
  
    
    <% @messages.each do |message| %> 
<div class="message"> 
  <p class="content"><%= message.content %></p> 
  <p class="time"><%= message.created_at %></p> 
</div> 
<% end %>
    <%= link_to 'New Message', "messages/new" %>
  </div>
</div>
# new messages
<%= form_for(@message) do |f| %>  
  <div class="field"> 
    <%= f.label :message %><br> 
    <%= f.text_area :content %> 
  </div> 
  <div class="actions"> 
    <%= f.submit "Create" %> 
  </div> 
<% end %>