class RemoveUserIdFromProblems < ActiveRecord::Migration
  def change
    remove_column :problems, :user_id, :integer
  end
end
