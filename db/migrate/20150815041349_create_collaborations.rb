class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.references :strategy, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :confirmed
      t.timestamps null: false
    end
  end
end
