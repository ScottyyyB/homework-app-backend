class AddTeacherUser < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :teacher, :boolean, default: false
  	add_column :users, :student, :boolean, default: false
  end
end
