class AddClassroomReferenceToHomework < ActiveRecord::Migration[5.1]
  def change
  	add_reference :homework, :classroom, foreign_key: true
  end
end
