class Product < ApplicationRecord
  has_many   :likes
  has_many   :comments
  has_many   :product_images
  belongs_to :user
  belongs_to :category
  belongs_to :brand
end
