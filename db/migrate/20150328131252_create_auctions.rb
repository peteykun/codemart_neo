class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.integer :problem_id
      t.integer :winning_bid
      t.timestamp :start_time
      t.timestamp :end_time

      t.timestamps null: false
    end
  end
end
