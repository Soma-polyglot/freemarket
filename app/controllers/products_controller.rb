class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @product.product_images.build
  end

  def create
    Product.create(product_params)
    #redirect_to root_path
  end
  
  private

  def product_params
    params.require(:product).permit(:name, :category_id, :description, :condition, :fee, :area, :date, :price )
    #.merge(user_id: current_user.id)
  end
   
end