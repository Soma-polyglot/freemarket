class Product < ApplicationRecord
  accepts_nested_attributes_for :product_image
  accepts_nested_attributes_for :brand
  has_many   :comments
  has_many   :users
  has_many   :product_images
  belongs_to :user
  
  belongs_to :category
  belongs_to :area
  belongs_to :size
  belongs_to :conditon

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :dondition
  belongs_to_active_hash :burden
  belongs_to_active_hash :sending
  belongs_to_active_hash :pattern

  def previous
    Product.where("id < ?", self.id).order("id DESC").first
  end
 
  def next
    Product.where("id > ?", self.id).order("id ASC").first
  end

end
