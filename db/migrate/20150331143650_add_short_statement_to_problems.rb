class AddShortStatementToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :short_statement, :text
  end
end
