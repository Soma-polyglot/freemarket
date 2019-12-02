class SignupController < ApplicationController

  before_action :validates_step1, only: :step2 # step1のバリデーション
  before_action :validates_step2, only: :step3 # step2のバリデーション
  before_action :validates_step3, only: :create

  def step1
    @user = User.new 
  end

  def step2
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:birthday] = Date.new(user_params["birthday(1i)"]&.to_i, user_params["birthday(2i)"]&.to_i, user_params["birthday(3i)"]&.to_i)
    @user = User.new 
  end

  def step3
    session[:phone_number] = user_params[:phone_number]
    @user = User.new
    @user.build_address
  end

  def create
    @user = User.new(user_params_b)
    
    if @user.save
      sign_in User.find(@user.id) unless user_signed_in?
      redirect_to new_card_path(@user.id)
    else
      redirect_to step3_signup_index_path
    end
  end

  def done
  end

  private
  def user_params
    params.require(:user).permit(
      :nickname, 
      :email, 
      :password, 
      :last_name, 
      :first_name, 
      :last_name_kana, 
      :first_name_kana, 
      :birthday,
      :phone_number
  )
  end

  def user_params_b
    params.require(:user).permit(address_attributes:[:id, :postal_code, :prefecture, :city, :address, :building, :telephone_number]).merge(
    nickname: session[:nickname], 
    email: session[:email], 
    password: session[:password], 
    last_name: session[:last_name], 
    first_name: session[:first_name], 
    last_name_kana: session[:last_name_kana], 
    first_name_kana: session[:first_name_kana], 
    birthday: session[:birthday],
    phone_number: session[:phone_number]
    )
  end

  def validates_step1
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]

    if user_params["birthday(1i)"] == "" || user_params["birthday(2i)"] == "" || user_params["birthday(3i)"] == ""
      session[:birthday] = "" 
    else
      session[:birthday] = Date.new(user_params["birthday(1i)"]&.to_i, user_params["birthday(2i)"]&.to_i, user_params["birthday(3i)"]&.to_i)
    end

    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      last_name: session[:last_name], 
      first_name: session[:first_name], 
      last_name_kana: session[:last_name_kana], 
      first_name_kana: session[:first_name_kana], 
      birthday: session[:birthday],
      phone_number: "09012345678"
    )
    render '/signup/step1' unless @user.valid?
  end

  def validates_step2
    session[:phone_number] = user_params[:phone_number]
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      last_name: session[:last_name], 
      first_name: session[:first_name], 
      last_name_kana: session[:last_name_kana], 
      first_name_kana: session[:first_name_kana], 
      birthday: session[:birthday],
      phone_number: session[:phone_number]
    )
    render '/signup/step2' unless @user.valid?
  end 

  def validates_step3
    @user = User.new(
      params.require(:user).permit(address_attributes:[:id, :postal_code, :prefecture, :city, :address, :building, :telephone_number]).merge(
        nickname: session[:nickname], 
        email: session[:email], 
        password: session[:password], 
        last_name: session[:last_name], 
        first_name: session[:first_name], 
        last_name_kana: session[:last_name_kana], 
        first_name_kana: session[:first_name_kana], 
        birthday: session[:birthday],
        phone_number: session[:phone_number]
        )
    )
    render '/signup/step3' unless @user.valid?
  end 
end

