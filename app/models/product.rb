class Product < ApplicationRecord

  has_many   :comments
  has_many   :product_images, dependent: :destroy
  belongs_to :user
  belongs_to :brand
  belongs_to :category
  belongs_to :user

  accepts_nested_attributes_for :product_images


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :condition
  belongs_to_active_hash :burden
  belongs_to_active_hash :sending
  belongs_to_active_hash :pattern
  belongs_to_active_hash :delivery


  def previous
    Product.where("id < ?", self.id).order("id DESC").first
  end
 
  def next
    Product.where("id > ?", self.id).order("id ASC").first
  end

end
