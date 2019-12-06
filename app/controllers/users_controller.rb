class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end
  
  def show
    @user = User.find(params[:id])
    @nickname = user.nickname
    @products = user.products
  end

  def index
  end
end
