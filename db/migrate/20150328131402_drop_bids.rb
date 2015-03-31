class DropBids < ActiveRecord::Migration
  def up
    drop_table :bids
  end
end
