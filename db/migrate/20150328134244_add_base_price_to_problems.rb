class AddBasePriceToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :base_price, :integer
  end
end
