class ProductsController < ApplicationController
  require 'payjp'
  before_action :set_card, only: [:purchase,:pay]
  before_action :set_product, only: [:show,:purchase,:pay,:edit,:update,:destroy]

  def index

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
    @product.destroy
    redirect_to root_path
  end

  def edit
    @product.product_images.build
  end

  def update
    @product.update(product_params)
  end
  
  def purchase
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
  @product.update(status: 1)
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