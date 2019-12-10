class ProductsController < ApplicationController
  require 'payjp'
  before_action :set_card, only: [:purchase,:pay]
  before_action :set_product, only: [:show,:purchase,:pay]

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
    @rady = Product.where(category_id: 1)
    @RADY = @rady.limit(10).order(created_at: :desc)
    @mens = Product.where(category_id: 2)
    @MENS = @mens.limit(10).order(created_at: :desc)
    @camera = Product.where(category_id: 3)
    @CAMERA = @camera.limit(10).order(created_at: :desc)
    @toy = Product.where(category_id: 4)
    @TOY = @toy.limit(10).order(created_at: :desc)
    @chanel = Product.where(brand_id: 1)
    @CHANEL = @chanel.limit(10).order(created_at: :desc)
    @vuitton = Product.where(brand_id: 2)
    @VUITTON = @vuitton.limit(10).order(created_at: :desc)
    @supreme = Product.where(brand_id: 3)
    @SUPREME = @supreme.limit(10).order(created_at: :desc)
    @nike = Product.where(brand_id: 4)
    @NIKE = @nike.limit(10).order(created_at: :desc)

  end

  def show    
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
  
  def purchase
    @user = User.find(params[:id])
    if @card.blank?
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    :amount => @product.price, 
    :customer => @card.customer_id, 
    :currency => 'jpy', 
  )
  redirect_to root_path 
  end


  private

  def set_card
    @card = Card.find_by(user_id: current_user.id) if Card.where(user_id: current_user.id).present?
  end

  def product_params
    params.require(:product).permit(:name, :description, :category_id, :size, :brand_id, :condition, :fee, :area, :date, :price, :user_id, :method, product_images_attributes:[:image] ) .merge(user_id:current_user.id )
  end
   
  def set_product
    @product = Product.find(params[:id])
  end
end