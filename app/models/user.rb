class User < ActiveRecord::Base
  has_many :classrooms, foreign_key: :teacher_id

  validates :username, uniqueness: true
  validates :name, presence: true
  validates :teacher, :student, inclusion: { in: [true, false] }
  has_secure_password
end
