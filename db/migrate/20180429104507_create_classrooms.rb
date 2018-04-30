class CreateClassrooms < ActiveRecord::Migration[5.1]
  def change
    create_table :classrooms do |t|
      t.integer :grade
      t.string :name
      t.integer :teacher_id

      t.timestamps
    end
  end
end
