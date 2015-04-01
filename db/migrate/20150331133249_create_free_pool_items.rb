class CreateFreePoolItems < ActiveRecord::Migration
  def change
    create_table :free_pool_items do |t|
      t.integer :problem_id

      t.timestamps null: false
    end
  end
end
