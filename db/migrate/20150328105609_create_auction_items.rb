class CreateAuctionItems < ActiveRecord::Migration
  def change
    create_table :auction_items do |t|
      t.integer :program_id
      t.integer :winning_bid
      t.timestamp :start_time
      t.timestamp :end_time

      t.timestamps null: false
    end
  end
end
