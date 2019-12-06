class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.references :seller,       null: false, foreign_key: { to_table: :users }
      t.string     :name,         null: false
      t.references :category,     null: false, foreign_key: true
      t.references :brand,        foreign_key: true
      t.integer    :price,        null: false
      t.text       :description,  null: false
      t.integer    :condition,    null: false
      t.integer    :area,         null: false    
      t.integer    :size,         null: false  
      t.integer    :status,       null: false
      t.references :buyer,        foreign_key: { to_table: :users }
      t.string     :fee,          null: false
      t.string     :date,         null: false
      t.timestamps
    end
  end
end
