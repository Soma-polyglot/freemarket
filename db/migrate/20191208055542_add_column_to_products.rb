class AddColumnToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :delivery_id, :integer
    add_column :products, :status, :integer
  end
end
