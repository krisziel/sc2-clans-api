class AddClanToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :clan_id, :integer
    add_column :players, :clan_tag, :string
  end
end
