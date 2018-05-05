class User < ActiveRecord::Base
  has_many :classrooms, foreign_key: :teacher_id

  validates :name, uniqueness: true
  validates :name, presence: true
  validates :teacher, :student, inclusion: { in: [true, false] }
end
