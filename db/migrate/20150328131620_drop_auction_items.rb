class DropAuctionItems < ActiveRecord::Migration
  def up
    drop_table :auction_items
  end
end
