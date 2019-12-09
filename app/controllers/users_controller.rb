class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end
  
  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @products = Product.limit(10).order(created_at: :desc)
    @redy = @products.eager_load(:category).where(id: 1)
    @mens = @products.eager_load(:category).where(id: 2)
    @camera = @products.eager_load(:category).where(id: 3)
    @toys = @products.eager_load(:brand).where(id: 4)
    @chanel = @products.eager_load(:brand).where(id: 1)
    @vuitton = @products.eager_load(:brand).where(id: 2)
    @supreme = @products.eager_load(:brand).where(id: 3)
    @nike = @products.eager_load(:brand).where(id: 4)
    # @products = @user.products

  end




  def signout
    @user = User.find(params[:id])
  end

  

end
