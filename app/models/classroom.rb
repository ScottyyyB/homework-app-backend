class Classroom < ApplicationRecord
  belongs_to :teacher, class_name: 'User'
  has_many :students
  has_many :homework
  has_many :users, through: :students

  validates :teacher_id, :user_ids, presence: true

  validates :name, :grade, presence: true
end
