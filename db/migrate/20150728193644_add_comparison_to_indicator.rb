class AddComparisonToIndicator < ActiveRecord::Migration
  def change
    add_column :indicators, :comparison, :integer
  end
end
