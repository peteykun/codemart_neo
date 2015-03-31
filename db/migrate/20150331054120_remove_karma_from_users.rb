class RemoveKarmaFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :karma, :float
  end
end
