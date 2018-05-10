class ClassroomShowSerializer < ActiveModel::Serializer
  attributes :id, :grade, :name, :teacher
  has_many :users

  def teacher
    object.teacher.username
  end
end