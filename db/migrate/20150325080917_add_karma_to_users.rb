class AddKarmaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :karma, :float
  end
end
