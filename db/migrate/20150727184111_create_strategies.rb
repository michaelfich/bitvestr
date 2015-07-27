class CreateStrategies < ActiveRecord::Migration
  def change
    create_table :strategies do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :interval

      t.timestamps null: false
    end
  end
end
