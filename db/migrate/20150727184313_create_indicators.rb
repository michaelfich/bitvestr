class CreateIndicators < ActiveRecord::Migration
  def change
    create_table :indicators do |t|
      t.references :strategy, index: true, foreign_key: true
      t.string :name
      t.float :value

      t.timestamps null: false
    end
  end
end
