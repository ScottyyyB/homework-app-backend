class Classroom < ApplicationRecord
  belongs_to :teacher, class_name: 'User'
  has_many :students
  has_many :users, through: :students

  validates :teacher_id, presence: true
  validates_presence_of :user_ids, :message => "Students must be added" 

  validates :name, :grade, presence: true
end
