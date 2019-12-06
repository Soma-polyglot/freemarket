class ProductsController < ApplicationController
  def index
    @products = Product.limit(10).order(created_at: :desc)
    @redy = @products.eager_load(:category).where(id: 1)
    @mens = @products.eager_load(:category).where(id: 2)
    @camera = @products.eager_load(:category).where(id: 3)
    @toys = @products.eager_load(:brand).where(id: 4)
    @chanel = @products.eager_load(:brand).where(id: 1)
    @vuitton = @products.eager_load(:brand).where(id: 2)
    @supreme = @products.eager_load(:brand).where(id: 3)
    @nike = @products.eager_load(:brand).where(id: 4)
  end

  def show    
    @product = Product.find(params[:id])
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