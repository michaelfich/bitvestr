class AddLongNameToFormula < ActiveRecord::Migration
  def change
    rename_column :formulas, :display, :abbreviation
    add_column :formulas, :full_name, :string
  end
end
