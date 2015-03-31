class DropSolutions < ActiveRecord::Migration
  def up
    drop_table :solutions
  end
end
