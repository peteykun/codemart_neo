class RemoveRegionIdFromProblems < ActiveRecord::Migration
  def change
    remove_column :problems, :region_id, :integer
  end
end
