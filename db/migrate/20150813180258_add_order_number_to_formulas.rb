class AddOrderNumberToFormulas < ActiveRecord::Migration
  def change
    add_column :formulas, :order_number, :integer
    add_index :formulas, :order_number
  end
end
