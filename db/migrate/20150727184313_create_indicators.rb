class CreateIndicators < ActiveRecord::Migration
  def change
    create_table :indicators do |t|
      t.references :strategy, index: true, foreign_key: true
      t.string :name
      t.decimal :value, precision: 12, scale: 8

      t.timestamps null: false
    end
  end
end
