class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string     :name,         null: false
      t.integer    :price,        null: false
      t.text       :description,  null: false
      t.integer    :condition,    null: false
      t.integer    :area,         null: false    
      t.integer    :size,         null: false  
      t.integer    :fee,          null: false
      t.integer    :date,         null: false
      t.references :brand,        foreign_key: true
      t.references :category,     null: false, foreign_key: true
      t.references :user,         null: false, foreign_key: true
      t.timestamps
    end
  end
end
