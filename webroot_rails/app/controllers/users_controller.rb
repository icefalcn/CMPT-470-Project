class UsersController < ApplicationController
  def register 
    @user = User.new(params[:user])
    
    if @user.valid?
      redirect_to root_url, notice: 'User is valid'
    end
      
    @user.save
    #redirect_to @user
  end 
  
  def edit
    @user = Users.find(params[:id])
  end
  
  def update
    @user = Users.find(params[:id])
      if @user.update(user_params)
        redirect_to @user
      else
        render 'edit'
      end
  end
  
  def login
    #@user = Users.find(params[:id])
  end 
  
  def retrieve 
    @user = Users.find(params[:id])
  end 
  
  private
  def user_params
    params.requires(:user).permit(:username, :password, :email)
  end
  
end
