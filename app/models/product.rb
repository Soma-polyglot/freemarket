class Product < ApplicationRecord
  has_many   :likes
  has_many   :comments
  has_many   :product_images
  belongs_to :user
  belongs_to :brand
  belongs_to :category

  def previous
    Product.where("id < ?", self.id).order("id DESC").first
  end
 
  def next
    Product.where("id > ?", self.id).order("id ASC").first
  end

end
