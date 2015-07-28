class AddBuySellToIndicators < ActiveRecord::Migration
  def change
    add_column :indicators, :action, :boolean
  end
end
