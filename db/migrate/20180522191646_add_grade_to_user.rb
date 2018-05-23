class AddGradeToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :grade, :integer
  end
end
