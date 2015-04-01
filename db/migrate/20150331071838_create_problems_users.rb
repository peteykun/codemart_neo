class CreateProblemsUsers < ActiveRecord::Migration
  def change
    create_table :problems_users do |t|
      t.integer :problem_id
      t.integer :user_id
    end
  end
end
