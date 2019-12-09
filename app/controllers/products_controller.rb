class ProductsController < ApplicationController
  def index
    # @products = Product.limit(10).order(created_at: :desc)
    # @redy = @products.eager_load(:category).where(id: 1)
    # @mens = @products.eager_load(:category).where(id: 2)
    # @camera = @products.eager_load(:category).where(id: 3)
    # @toys = @products.eager_load(:brand).where(id: 4)
    # @chanel = @products.eager_load(:brand).where(id: 1)
    # @vuitton = @products.eager_load(:brand).where(id: 2)
    # @supreme = @products.eager_load(:brand).where(id: 3)
    # @nike = @products.eager_load(:brand).where(id: 4)
    @rady = Product.eager_load(:category).where(id: 1)
    @RADY = @rady.limit(10).order(created_at: :desc)

    @mens = Product.eager_load(:category).where(id: 2)
    @MENS = @mens.limit(10).order(created_at: :desc)

    @camera = Product.eager_load(:category).where(id: 3)
    @CAMERA = @camera.limit(10).order(created_at: :desc)

    @toy = Product.eager_load(:category).where(id: 4)
    @TOY = @toy.limit(10).order(created_at: :desc)

    @chanel = Product.eager_load(:brand).where(id: 1)
    @CHANEL = @chanel.limit(10).order(created_at: :desc)

    @vuitton = Product.eager_load(:brand).where(id: 2)
    @VUITTON = @vuitton.limit(10).order(created_at: :desc)

    @supreme = Product.eager_load(:brand).where(id: 3)
    @SUPREME = @supreme.limit(10).order(created_at: :desc)

    @nike = Product.eager_load(:brand).where(id: 4)
    @NIKE = @nike.limit(10).order(created_at: :desc)

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
    redirect_to root_path
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to root_path
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    product = Product.find(params[:id])
    product.update(product_params)
  end

  
  private
  def product_params
    params.require(:product).permit(:name, :description, :category_id, :size, :brand_id, :condition, :fee, :area, :date, :price, :user_id, :method, product_images_attributes:[:image] ) .merge(user_id:current_user.id )
  end
   
end