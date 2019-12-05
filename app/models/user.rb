class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable, omniauth_providers: %i[facebook google_oauth2]
  has_one :address
  accepts_nested_attributes_for :address
  has_one :card
  has_many :sns_credentials, dependent: :destroy

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

  def self.without_sns_data(auth)
    user = User.find_by(email: auth.info.email)

      if user.present?
        sns = SnsCredential.create(
          uid: auth.uid,
          provider: auth.provider,
          user_id: user.id
        )
      else
        user = User.new(
          nickname: auth.info.name,
          email: auth.info.email,
        )
        sns = SnsCredential.new(
          uid: auth.uid,
          provider: auth.provider
        )
      end
      return { user: user ,sns: sns}
    end

   def self.with_sns_data(auth, snscredential)
    user = User.find_by(id: snscredential.user_id)
    unless user.present?
      user = User.new(
        nickname: auth.info.name,
        email: auth.info.email,
      )
    end
    return {user: user}
   end

   def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      user = with_sns_data(auth, snscredential)[:user]
      sns = snscredential
    else
      user = without_sns_data(auth)[:user]
      sns = without_sns_data(auth)[:sns]
    end
    return { user: user ,sns: sns}
  end


end
