class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :auction_id
      t.integer :user_id
      t.integer :amount

      t.timestamps null: false
    end
  end
end
