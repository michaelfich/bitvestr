class AddPeriodToIndicator < ActiveRecord::Migration
  def change
    add_column :indicators, :period, :integer
  end
end
