class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string     :name,               null: false
      t.integer    :price,              null: false
      t.text       :description,        null: false
      t.integer    :condition_id,       null: false
      t.integer    :prefecture_id,      null: false    
      t.integer    :pattern_id,         null: false  
      t.integer    :burden_id,          null: false
      t.integer    :sending_id,         null: false
      t.integer    :brand_id,     foreign_key: true   
      t.references :category,     null: false, foreign_key: true
      t.references :user,         null: false, foreign_key: true
      t.timestamps
    end
  end
end
