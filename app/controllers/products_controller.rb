class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    #@parents = Category.all.order("id ASC").limit(13)
  end

  def create
    @product = Product.new(product_params)
    redirect_to root_path
  end
  
  private

  def product_params
    params.require(:product).permit(:name, :description, :status, :fee, :area, :date, :price )
  end
   
end