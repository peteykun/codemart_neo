class AddTestingVariablesToSolution < ActiveRecord::Migration
  def change
    add_column :solutions, :tested, :boolean
    add_column :solutions, :success, :boolean
  end
end
