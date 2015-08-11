class RemoveActionFromIndicator < ActiveRecord::Migration
  def change
    remove_column :indicators, :action
  end
end
