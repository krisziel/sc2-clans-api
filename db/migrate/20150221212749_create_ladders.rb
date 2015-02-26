class CreateLadders < ActiveRecord::Migration
  def change
    create_table :ladders do |t|
      t.string :name
      t.integer :bnet_id
      t.integer :division
      t.string :league
      t.string :region
      t.timestamps
    end
  end
end
