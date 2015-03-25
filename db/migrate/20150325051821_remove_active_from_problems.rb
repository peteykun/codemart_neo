class RemoveActiveFromProblems < ActiveRecord::Migration
  def change
    remove_column :problems, :active, :boolean
  end
end
