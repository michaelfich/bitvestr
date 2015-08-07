class ChangeIndicatorValueToInteger < ActiveRecord::Migration
  def change
    change_column :indicators, :value, :integer
  end
end
