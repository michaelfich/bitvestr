class AddTypeToStrategy < ActiveRecord::Migration
  def change
    add_column :strategies, :classification, :string
  end
end
