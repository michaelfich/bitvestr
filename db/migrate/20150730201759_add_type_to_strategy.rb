class AddTypeToStrategy < ActiveRecord::Migration
  def change
    add_column :strategies, :type, :string
  end
end
