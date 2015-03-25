class AddRewardToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :reward, :integer
  end
end
