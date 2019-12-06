class Category < ApplicationRecord
  has_many :products
  has_many :brands
  has_ancestry
end
