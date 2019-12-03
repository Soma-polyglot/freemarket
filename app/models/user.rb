class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :address
  accepts_nested_attributes_for :address
  has_one :card

  # step1入力項目
  validates :nickname,                presence: true, length: {maximum: 20}
  validates :email,                   presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password,                presence: true, length: {minimum: 7, maximum: 128}
  validates :last_name,               presence: true, format: { with: /\A[^ -~｡-ﾟ]+\z/}
  validates :first_name,              presence: true, format: { with: /\A[^ -~｡-ﾟ]+\z/}
  validates :last_name_kana,          presence: true, format: { with: /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/}
  validates :first_name_kana,         presence: true, format: { with: /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/}
  validates :birthday,                presence: true

  # step2入力項目
  validates :phone_number,            presence: true, format: { with: /\A\d{10}$|^\d{11}\z/}




end
