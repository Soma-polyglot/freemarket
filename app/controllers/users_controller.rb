class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def show
    @user = User.find(params[:id])
    # @products = @user.products
  end




  def signout
    @user = User.find(params[:id])
  end

  

end
