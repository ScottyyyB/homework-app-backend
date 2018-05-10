class ClassroomSerializer < ActiveModel::Serializer
  attributes :id, :grade, :name, :teacher, :student_count

  def teacher
    object.teacher.username
  end

  def student_count
    object.students.count
  end
end
