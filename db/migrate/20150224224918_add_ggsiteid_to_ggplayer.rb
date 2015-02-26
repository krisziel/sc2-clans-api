class AddGgsiteidToGgplayer < ActiveRecord::Migration
  def change
    add_column :ggplayers, :ggsiteid, :integer
  end
end
