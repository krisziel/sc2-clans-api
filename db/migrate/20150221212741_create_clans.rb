class CreateClans < ActiveRecord::Migration
  def change
    create_table :clans do |t|
      t.string :name
      t.string :tag
      t.string :region
      t.timestamps
    end
  end
end
