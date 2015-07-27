class CreateTicks < ActiveRecord::Migration
  def change
    create_table :ticks do |t|
      t.integer :interval
      t.float :last_price
      t.float :volume
      t.timestamp :datetime
    end
  end
end
