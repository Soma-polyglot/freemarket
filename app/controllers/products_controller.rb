class ProductsController < ApplicationController
  require 'payjp'
  before_action :set_card, only: [:purchase,:pay]
  before_action :set_product, only: [:show,:purchase,:pay]

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
  end

  def new
    @product = Product.new
    #@parents = Category.all.order("id ASC").limit(13)
  end

  def create
    @product = Product.new(product_params)
    redirect_to root_path
  end

  def purchase
    @user = User.find(params[:id])
    #Cardテーブルは前回記事で作成、テーブルからpayjpの顧客IDを検索
    if @card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    :amount => @product.price, #支払金額を入力（itemテーブル等に紐づけても良い）
    :customer => @card.customer_id, #顧客ID
    :currency => 'jpy', #日本円
  )
  redirect_to root_path #完了画面に移動
  end


  private

  def set_card
    @card = Card.find_by(user_id: current_user.id) if Card.where(user_id: current_user.id).present?
  end

  def product_params
    params.require(:product).permit(:name, :description, :status, :fee, :area, :date, :price )
  end
   
  def set_product
    @product = Product.find(params[:id])
  end
end